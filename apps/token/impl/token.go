package impl

import (
	"context"
	"fmt"
	"time"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token/provider"
)

var (
	tokenTableName = "sapling_scaffold_token"
)

// IssueToken 处理登录颁发令牌的主流程，包含前后安全检查
func (s *service) IssueToken(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	const fn = "Service.IssueToken"
	const lp = fn + " ---> "

	// 前置安全检查
	s.log.Debugf("%s开始前置安全检查", lp)
	if err := s.BeforeLoginSecurityCheck(ctx, req); err != nil {
		s.log.Warnf("%s前置安全检查失败: %v", lp, err)
		return nil, exception.NewBadRequest(err.Error())
	}
	s.log.Debugf("%s前置安全检查通过", lp)

	// 颁发令牌
	s.log.Infof("%s调用 IssueTokenNow", lp)
	tk, err := s.IssueTokenNow(ctx, req)
	if err != nil {
		s.log.Errorf("%s颁发令牌失败: %v", lp, err)
		return nil, err
	}

	// 登陆后安全检查
	s.log.Debugf("%s开始后置安全检查", lp)
	if err := s.AfterLoginSecurityCheck(ctx, req.VerifyCode, tk); err != nil {
		s.log.Warnf("%s后置安全检查失败: %v", lp, err)
		return nil, exception.NewBadRequest(err.Error())
	}
	s.log.Debugf("%s后置安全检查通过", lp)

	s.log.Infof("%s令牌颁发完成", lp)
	return tk, nil
}

// IssueTokenNow 调用 provider 并持久化、新旧 token 清理
func (s *service) IssueTokenNow(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	const fn = "Service.IssueTokenNow"
	const lp = fn + " ---> "

	// 获取令牌颁发器
	issuer := provider.GetTokenIssuer(req.GrantType)
	// 确保有provider
	if issuer == nil {
		msg := fmt.Sprintf("不支持的授权类型: %v", req.GrantType)
		s.log.Warnf("%s%s", lp, msg)
		return nil, exception.NewBadRequest("grant type %v not support", req.GrantType)
	}

	// 颁发 token
	s.log.Info(req, "---> IssueTokenNow")
	tk, err := issuer.IssueToken(ctx, req)
	if err != nil {
		s.log.Errorf("%s颁发流程出错: %v", lp, err)
		return nil, err
	}

	// 非 DryRun 模式，持久化并清理
	if !req.DryRun {
		if _, err := s.db.Table(tokenTableName).Insert(tk); err != nil {
			s.log.Errorf("%s写库失败: %v", lp, err)
			return nil, exception.NewInternalServerError("inserted token (%v) error, %v", tk.Username, err)
		}

		s.log.Debugf("%s清理旧 Web 登录令牌", lp)
		if err := s.blockOtherWebToken(ctx, tk); err != nil {
			s.log.Warnf("%s清理旧令牌失败: %v", lp, err)
		}
	}
	s.log.Debugf("%sIssueTokenNow 完成返回", lp)
	return tk, nil
}

func (s *service) BeforeLoginSecurityCheck(ctx context.Context, req *token.IssueTokenRequest) error {
	// 连续登录失败检测
	// if err := s.checker.MaxFailedRetryCheck(ctx, req); err != nil {
	//	return exception.NewBadRequest("%v", err)
	// }

	// IP保护检测
	// err := s.checker.IPProtectCheck(ctx, req)
	// if err != nil {
	//	return err
	// }

	s.log.Debug("security check complete")
	return nil
}

func (s *service) AfterLoginSecurityCheck(ctx context.Context, verifyCode string, tk *token.Token) error {
	// 如果有校验码, 则直接通过校验码检测用户身份安全
	// if verifyCode != "" {
	//	s.log.Debugf("verify code provided, check code ...")
	//	_, err := s.code.VerifyCode(ctx, code.NewVerifyCodeRequest(tk.Username, verifyCode))
	//	if err != nil {
	//		return exception.NewPermissionDeny("verify code invalidate, error, %v", err)
	//	}
	//	s.log.Debugf("verfiy code check passed")
	//	return nil
	// }

	// 异地登录检测
	// err := s.checker.OtherPlaceLoggedInChecK(ctx, tk)
	// if err != nil {
	//	return exception.NewVerifyCodeRequiredError("异地登录检测失败: %v", err)
	// }
	//
	// // 长时间未登录检测
	// err = s.checker.NotLoginDaysChecK(ctx, tk)
	// if err != nil {
	//	return exception.NewVerifyCodeRequiredError("长时间未登录检测失败: %v", err)
	// }

	return nil
}

// 撤销Token
func (s *service) RevolkToken(ctx context.Context, req *token.RevolkTokenRequest) (
	*token.Token, error) {
	tk, err := s.get(ctx, req.AccessToken)
	if err != nil {
		return nil, err
	}

	if tk.RefreshToken != req.RefreshToken {
		return nil, exception.NewBadRequest("refresh token not connrect")
	}

	if err := s.delete(ctx, tk); err != nil {
		return nil, err
	}
	return tk, nil
}

// ValidateToken 校验 AccessToken 合法性并返回 Token 对象
func (s *service) ValidateToken(ctx context.Context, req *token.ValidateTokenRequest) (*token.Token, error) {
	const fn = "Service.ValidateToken"
	const lp = fn + " ---> "

	// 请求验证
	if err := req.Validate(); err != nil {
		s.log.Warnf("%s请求参数校验失败: %v", lp, err)
		return nil, exception.NewBadRequest(err.Error())
	}

	// 从存储中获取
	tk, err := s.get(ctx, req.AccessToken)
	if err != nil {
		s.log.Warnf("%s令牌查询失败: %v", lp, err)
		return nil, exception.NewUnauthorized(err.Error())
	}

	s.log.Infof("%s令牌校验通过", lp)
	return tk, nil
}

func (s *service) reuseToken(ctx context.Context, tk *token.Token) error {
	// 刷新token过期的，不允许复用
	if tk.CheckRefreshIsExpired() {
		return exception.NewRefreshTokenExpired("refresh_token: %v expoired", tk.RefreshToken)
	}

	// access token延长一个过期周期
	// tk.AccessExpiredAt = time.Now().Add(time.Duration(token.DEFAULT_ACCESS_TOKEN_EXPIRE_SECOND) * time.Second).Unix()
	tk.AccessExpiredAt = time.Now().Add(time.Duration(token.DEFAULT_ACCESS_TOKEN_EXPIRE_SECOND)*time.Second).Unix() * 1000
	// refresh token延长一个过期周期
	tk.RefreshExpiredAt = time.Unix(tk.RefreshExpiredAt/1000, 0).Add(time.Duration(token.DEFAULT_REFRESH_TOKEN_EXPIRE_SECOND)*time.Second).Unix() * 1000
	// tk.RefreshExpiredAt = time.Unix(tk.RefreshExpiredAt, 0).Add(time.Duration(token.DEFAULT_REFRESH_TOKEN_EXPIRE_SECOND) * time.Second).Unix()
	return s.save(ctx, tk)
}

func (s *service) DescribeToken(ctx context.Context, req *token.DescribeTokenRequest) (*token.Token, error) {
	if err := req.Validate(); err != nil {
		return nil, exception.NewBadRequest(err.Error())
	}

	tk, err := s.get(ctx, req.DescribeValue)
	if err != nil {
		return nil, exception.NewUnauthorized(err.Error())
	}
	return tk, nil
}

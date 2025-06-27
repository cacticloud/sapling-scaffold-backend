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
	tokenTableName = "mcenter_token"
)

func (s *service) IssueToken(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	// 登陆前安全检查
	if err := s.BeforeLoginSecurityCheck(ctx, req); err != nil {
		fmt.Println(err)
		return nil, exception.NewBadRequest(err.Error())
	}

	// 颁发令牌
	tk, err := s.IssueTokenNow(ctx, req)
	if err != nil {
		return nil, err
	}

	// 登陆后安全检查
	if err := s.AfterLoginSecurityCheck(ctx, req.VerifyCode, tk); err != nil {
		fmt.Println(err)
		return nil, exception.NewBadRequest(err.Error())
	}

	// 还原用户上次登陆状态(上次登陆的空间)
	// err = s.RestoreUserState(ctx, tk)
	// if err != nil {
	//	return nil, err
	// }

	return tk, nil
}

func (s *service) IssueTokenNow(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	// 获取令牌颁发器
	issuer := provider.GetTokenIssuer(req.GrantType)
	// 确保有provider
	if issuer == nil {
		return nil, exception.NewBadRequest("grant type %v not support", req.GrantType)
	}

	// 颁发token
	tk, err := issuer.IssueToken(ctx, req)
	if err != nil {
		return nil, err
	}

	if !req.DryRun {
		if _, err := s.db.Table(tokenTableName).Insert(tk); err != nil {
			return nil, exception.NewInternalServerError("inserted token (%v) error, %v", tk.Username, err)
		}

		// 关闭之前的web登录
		if err := s.blockOtherWebToken(ctx, tk); err != nil {
			return nil, err
		}
	}

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

func (s *service) ValidateToken(ctx context.Context, req *token.ValidateTokenRequest) (*token.Token, error) {
	if err := req.Validate(); err != nil {
		return nil, exception.NewBadRequest(err.Error())
	}

	tk, err := s.get(ctx, req.AccessToken)
	if err != nil {
		return nil, exception.NewUnauthorized(err.Error())
	}

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

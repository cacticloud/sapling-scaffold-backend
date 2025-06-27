package impl

import (
	"context"
	"fmt"
	"time"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
)

// save 持久化新 Token
func (s *service) save(ctx context.Context, tk *token.Token) error {
	const fn = "service.save"
	const lp = fn + " ---> "

	s.log.Debugf("%s准备写入数据库, access_token=%s", lp, tk.AccessToken)
	if _, err := s.db.Table(tokenTableName).Insert(tk); err != nil {
		s.log.Errorf("%s写库失败 access_token=%s, err=%v", lp, tk.AccessToken, err)
		return exception.NewInternalServerError("写入 Token 失败：%v，%v", tk.AccessToken, err)
	}
	s.log.Infof("%s写库成功 access_token=%s", lp, tk.AccessToken)
	return nil
}

// get 根据 access_token 查询 Token，并校验过期
func (s *service) get(ctx context.Context, ak string) (*token.Token, error) {
	const fn = "service.get"
	const lp = fn + " ---> "

	s.log.Debugf("%s查询 Token, access_token=%s", lp, ak)

	// 用一个空的 token.Token 实例，不带任何初始字段
	ins := new(token.Token)

	// 只在 WHERE 里加 access_token 条件
	has, err := s.db.Table(tokenTableName).Where("access_token = ?", ak).Get(ins)
	if err != nil {
		s.log.Errorf("%s数据库查询异常 access_token=%s, err=%v", lp, ak, err)
		return nil, exception.NewInternalServerError("查询令牌失败：%v", err)
	}
	if !has {
		s.log.Warnf("%s未找到 Token, access_token=%s", lp, ak)
		return nil, exception.NewNotFound("令牌不存在：%v", ak)
	}

	// 过期检查
	if time.Now().Unix()-ins.IssueAt > token.DEFAULT_ACCESS_TOKEN_EXPIRE_SECOND {
		s.log.Warnf("%sToken 已过期 access_token=%s", lp, ak)
		return nil, exception.NewUnauthorized("令牌已过期")
	}

	s.log.Infof("%sToken 查询并校验通过 access_token=%s", lp, ak)
	return ins, nil
}

// update 更新 Token 的全部字段
func (s *service) update(ctx context.Context, tk *token.Token) error {
	const fn = "service.update"
	const lp = fn + " ---> "

	s.log.Debugf("%s准备更新 Token, access_token=%s", lp, tk.AccessToken)
	if _, err := s.db.Table(tokenTableName).Where("access_token = ?", tk.AccessToken).Update(tk); err != nil {
		s.log.Errorf("%s更新失败 access_token=%s, err=%v", lp, tk.AccessToken, err)
		return exception.NewInternalServerError("更新 Token 失败：%v，%v", tk.AccessToken, err)
	}
	s.log.Infof("%s更新成功 access_token=%s", lp, tk.AccessToken)
	return nil
}

// blockOtherWebToken 屏蔽同用户其他 Web 端登录的旧 Token
func (s *service) blockOtherWebToken(ctx context.Context, tk *token.Token) error {
	const fn = "service.blockOtherWebToken"
	const lp = fn + " ---> "

	// 仅针对 Web 平台生效
	if !tk.Platform.Equal(token.PLATFORM_WEB) {
		s.log.Debugf("%s非 Web 平台, 不处理旧 Token, platform=%v", lp, tk.Platform)
		return nil
	}

	now := time.Now().Unix()
	status := token.NewStatus()
	status.IsBlock = true
	status.BlockAt = now
	status.BlockReason = fmt.Sprintf("你于 %v 从其他设备登录，旧令牌已屏蔽", time.Unix(now, 0).Format(time.RFC3339))
	status.BlockType = token.BLOCK_TYPE_OTHER_PLACE_LOGGED_IN

	rs, err := s.db.Table(tokenTableName).
		Where("platform = ? AND user_id = ? AND issue_at < ? AND is_block = ?", token.PLATFORM_WEB, tk.UserId, tk.IssueAt, 0).
		Update(status)
	if err != nil {
		s.log.Warnf("%s屏蔽旧 Token 失败 user_id=%d, err=%v", lp, tk.UserId, err)
		return exception.NewInternalServerError("屏蔽旧 Token 失败：%v", err)
	}

	s.log.Infof("%s成功屏蔽 %d 条旧 Token for user_id=%d", lp, rs, tk.UserId)
	return nil
}

// delete 删除指定 Token
func (s *service) delete(ctx context.Context, ins *token.Token) error {
	const fn = "service.delete"
	const lp = fn + " ---> "

	if ins == nil || ins.AccessToken == "" {
		s.log.Warnf("%s无效的 Token 参数: nil 或空字符串", lp)
		return exception.NewBadRequest("无效的 Token 参数")
	}

	// 执行删除
	rs, err := s.db.Table(tokenTableName).Where("access_token = ?", ins.AccessToken).Delete()
	if err != nil {
		s.log.Errorf("%s删除失败 access_token=%s, err=%v", lp, ins.AccessToken, err)
		return exception.NewInternalServerError("删除 Token 失败：%v，%v", ins.AccessToken, err)
	}
	if rs == 0 {
		s.log.Warnf("%s未能删除任何记录 access_token=%s", lp, ins.AccessToken)
		return exception.NewNotFound("未找到要删除的 Token：%v", ins.AccessToken)
	}

	s.log.Infof("%s成功删除 Token access_token=%s", lp, ins.AccessToken)
	return nil
}

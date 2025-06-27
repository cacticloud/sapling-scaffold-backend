package impl

import (
	"context"
	"fmt"
	"time"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
)

func (s *service) save(ctx context.Context, tk *token.Token) error {
	if _, err := s.db.Table(tokenTableName).Insert(tk); err != nil {
		return exception.NewInternalServerError("inserted token(%v) error, %v",
			tk.AccessToken, err)
	}

	return nil
}

func (s *service) get(ctx context.Context, ak string) (*token.Token, error) {

	// ins := token.NewToken(token.NewIssueTokenRequest())
	ins := &token.Token{}

	if has, err := s.db.Table(tokenTableName).Where("access_token = ?", ak).Get(ins); err != nil || !has {
		if !has {
			return nil, exception.NewInternalServerError("get token %v no found", ak)
		}
		return nil, exception.NewInternalServerError("get token %v error, %v", ak, err)
	}

	return ins, nil
}

func (s *service) update(ctx context.Context, tk *token.Token) error {
	_, err := s.db.Table(tokenTableName).Where("access_token = ?", tk.AccessToken).Update(tk)
	if err != nil {
		return exception.NewInternalServerError("update token(%v) error, %v", tk.AccessToken, err)
	}

	return nil
}

func (s *service) blockOtherWebToken(ctx context.Context, tk *token.Token) error {
	// 如果不是web登陆, 不需要关闭之前的登录令牌
	if !tk.Platform.Equal(token.PLATFORM_WEB) {
		return nil
	}

	now := time.Now()
	status := token.NewStatus()
	status.IsBlock = true
	status.BlockAt = now.Unix()
	status.BlockReason = fmt.Sprintf("你于 %v 从其他地方通过 %v 登录", now.Format(time.RFC3339), tk.GrantType)
	status.BlockType = token.BLOCK_TYPE_OTHER_PLACE_LOGGED_IN

	rs, err := s.db.Table(tokenTableName).Where(
		"platform = ? AND user_id = ? AND issue_at < ? AND is_block = ?",
		token.PLATFORM_WEB,
		tk.UserId,
		tk.IssueAt,
		0,
	).Update(status)
	if err != nil {
		return err
	}
	s.log.Debugf("block %d tokens", rs)
	return nil
}

func (s *service) delete(ctx context.Context, ins *token.Token) error {
	if ins == nil || ins.AccessToken == "" {
		return fmt.Errorf("access tpken is nil")
	}

	result, err := s.db.Table(tokenTableName).Where("access_token = ?", ins.AccessToken).Delete()
	if err != nil {
		return exception.NewInternalServerError("delete token(%v) error, %v", ins.AccessToken, err)
	}

	if result == 0 {
		return exception.NewNotFound("token %v not found", ins.AccessToken)
	}

	return nil
}

package private_token

import (
	"context"
	"strconv"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token/provider"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
)

type issuer struct {
	token token.Service
	user  user.Service
	log   logger.Logger
}

func (i *issuer) Init() error {
	i.token = app.GetInternalApp(token.AppName).(token.Service)
	i.user = app.GetInternalApp(user.AppName).(user.Service)
	i.log = zap.L().Named("issuer.private_token")
	return nil
}

func (i *issuer) GrantType() token.GRANT_TYPE {
	return token.GRANT_TYPE_PRIVATE_TOKEN
}

func (i *issuer) validate(ctx context.Context, accessToken string) (*user.User, error) {
	if accessToken == "" {
		return nil, exception.NewUnauthorized("access token required")
	}

	// 判断凭证合法性
	tk, err := i.token.ValidateToken(ctx, token.NewValidateTokenRequest(accessToken))
	if err != nil {
		return nil, err
	}

	u, err := i.user.DescribeUser(ctx, user.NewDescriptUserRequestById(tk.UserId))
	if err != nil {
		return nil, exception.NewNotFound("describe user not found, %v", tk.UserId)
	}

	return u.User, nil
}

func (i *issuer) IssueToken(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	u, err := i.validate(ctx, req.AccessToken)
	if err != nil {
		return nil, err
	}

	// 3. 颁发Token
	newTk := token.NewToken(req)
	newTk.Domain = u.Spec.Domain
	newTk.Username = u.Spec.Username
	newTk.UserType = u.Spec.Type

	newTk.UserId = strconv.FormatInt(u.Spec.Id, 10)
	return newTk, nil
}

func init() {
	provider.Registe(&issuer{})
}

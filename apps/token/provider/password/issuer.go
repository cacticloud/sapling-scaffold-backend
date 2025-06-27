package password

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
	// 注册user实例，便于单测
	_ "github.com/cacticloud/sapling-scaffold-backend/apps/user/api"
	_ "github.com/cacticloud/sapling-scaffold-backend/apps/user/impl"
)

var (
	AUTH_FAILED = exception.NewUnauthorized("用户名或密码无效")
)

type issuer struct {
	user user.Service
	log  logger.Logger
}

func (i *issuer) Init() error {
	i.user = app.GetInternalApp(user.AppName).(user.Service)
	i.log = zap.L().Named("issuer.password")
	return nil
}

func (i *issuer) GrantType() token.GRANT_TYPE {
	return token.GRANT_TYPE_PASSWORD
}

func (i *issuer) validate(ctx context.Context, username, pass string) (*user.User, error) {
	if username == "" || pass == "" {
		return nil, AUTH_FAILED
	}

	// 检测用户的密码是否正确
	u, err := i.user.DescribeUser(ctx, user.NewDescriptUserRequestByName(username))
	if err != nil {
		return nil, AUTH_FAILED
	}
	if err := u.User.CheckPassword(pass); err != nil {
		return nil, AUTH_FAILED
	}

	// 检测密码是否过期
	// var expiredRemain, expiredDays uint
	switch u.User.Spec.Type {
	case user.TYPE_SUB:
		// 子账号过期策略
		// d, err := i.domain.DescribeDomain(ctx, domain.NewDescribeDomainRequestByName(u.Spec.Domain))
		// if err != nil {
		// 	return nil, err
		// }
		// ps := d.Spec.SecuritySetting.PasswordSecurity
		// expiredRemain, expiredDays = uint(ps.BeforeExpiredRemindDays), uint(ps.PasswordExpiredDays)
	default:
		// 主账号和管理员密码过期策略
		// expiredRemain, expiredDays = uint(u.Password.ExpiredRemind), uint(u.Password.ExpiredDays)
	}

	// 检查密码是否过期
	// err = u.Password.CheckPasswordExpired(expiredRemain, expiredDays)
	// if err != nil {
	// 	return nil, err
	// }

	return u.User, nil
}

func (i *issuer) IssueToken(ctx context.Context, req *token.IssueTokenRequest) (*token.Token, error) {
	u, err := i.validate(ctx, req.Username, req.Password)
	if err != nil {
		return nil, err
	}

	// 3. 颁发Token
	tk := token.NewToken(req)
	tk.Domain = u.Spec.Domain
	tk.Username = u.Spec.Username
	tk.UserType = u.Spec.Type
	tk.UserId = strconv.FormatInt(u.Spec.Id, 10)
	return tk, nil
}

func init() {
	provider.Registe(&issuer{
		user: app.GetInternalApp(user.AppName).(user.Service),
	})
}

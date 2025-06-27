package restful

import (
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/cache"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/emicklei/go-restful/v3"
)

const (
	// PRBAC_MODE 基于策略的权限校验
	PRBAC_MODE PermissionMode = 1

	// ACL_MODE 基于用户类型的权限校验
	ACL_MODE PermissionMode = 2
)

type PermissionMode int

type httpAuther struct {
	log  logger.Logger
	tk   token.Service
	mode PermissionMode
	// code             code.Service
	cache            cache.Cache
	codeCheckSilence time.Duration
}

func NewHttpAuther() *httpAuther {
	return &httpAuther{
		log: zap.L().Named("auther.restful"),
		tk:  app.GetInternalApp(token.AppName).(token.Service),
		// code:             app.GetInternalApp(code.AppName).(code.Service),
		cache:            cache.C(),
		codeCheckSilence: 30 * time.Minute,
		mode:             PRBAC_MODE,
	}
}

func (a *httpAuther) SetCodeCheckSilenceTime(t time.Duration) {
	a.codeCheckSilence = t
}

func (a *httpAuther) GoRestfulAuthFunc(req *restful.Request, resp *restful.Response, next *restful.FilterChain) {
	next.ProcessFilter(req, resp)
}

func (a *httpAuther) CheckAccessToken(req *restful.Request) (*token.Token, error) {
	// 获取用户Token, Token放在 Header Authorization
	ak := token.GetAccessTokenFromHTTP(req.Request)

	if ak == "" {
		return nil, token.ErrUnauthorized
	}

	// 调用GRPC 校验用户Token合法性
	tk, err := a.tk.ValidateToken(req.Request.Context(), token.NewValidateTokenRequest(ak))
	if err != nil {
		return nil, err
	}

	// 是不是需要返回用户的认证信息: 那个人, 那个空间下面， token本身的信息
	req.SetAttribute(token.TOKEN_ATTRIBUTE_NAME, tk)
	return tk, nil
}

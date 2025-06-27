package restful

import (
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/cache"
	"github.com/cacticloud/cactikit/http/label"
	"github.com/cacticloud/cactikit/http/response"
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

// PermissionMode 控制认证方式
type PermissionMode int

// httpAuther 用于 GoRestful 的认证中间件
type httpAuther struct {
	log              logger.Logger  // 日志
	tk               token.Service  // Token 服务
	mode             PermissionMode // 权限模式
	cache            cache.Cache    // 缓存，用于登录限流等
	codeCheckSilence time.Duration  // 验证码静默期
}

// NewHttpAuther 构造函数
func NewHttpAuther() *httpAuther {
	return &httpAuther{
		log:              zap.L().Named("auther.restful"),
		tk:               app.GetInternalApp(token.AppName).(token.Service),
		cache:            cache.C(),
		codeCheckSilence: 30 * time.Minute,
		mode:             PRBAC_MODE,
	}
}

// SetCodeCheckSilenceTime 设置验证码静默期
func (a *httpAuther) SetCodeCheckSilenceTime(t time.Duration) {
	a.codeCheckSilence = t
}

// GoRestfulAuthFunc GoRestful 认证过滤函数（Filter）
// 1. 先根据路由 Metadata(label.Auth) 判断是否需要认证
// 2. 如果需要，调用 CheckAccessToken 校验 AccessToken
// 3. 校验通过后，把 token 放入 Request Attribute，继续调用下一个 Filter 或 Handler
func (a *httpAuther) GoRestfulAuthFunc(req *restful.Request, resp *restful.Response, next *restful.FilterChain) {
	const fn = "auther.GoRestfulAuthFunc"
	const lp = fn + " ---> "

	// 请求拦截
	route := req.SelectedRoute()
	if route != nil {
		a.log.Debugf("%s请求到达 %s %s", lp, route.Method(), route.Path())
	}

	// 判断路由上 metadata[label.Auth] 是否开启认证
	if route != nil {
		if md := route.Metadata(); md != nil {
			if v, ok := md[label.Auth]; ok {
				if needAuth, _ := v.(bool); needAuth {
					a.log.Debugf("%s路由需要认证，开始检查 AccessToken", lp)
					tk, err := a.CheckAccessToken(req)
					if err != nil {
						a.log.Warnf("%sAccessToken 校验失败: %v", lp, err)
						response.Failed(resp, err)
						return
					}
					a.log.Infof("%sAccessToken 校验通过: user=%s domain=%s",
						lp, tk.Username, tk.Domain)
					// 将通过的 Token 放到 Request Attribute 里，供后续 Handler 使用
					req.SetAttribute(token.TOKEN_ATTRIBUTE_NAME, tk)
				}
			}
		}
	}

	// 继续后面的 Filter 或者真正的 handler
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

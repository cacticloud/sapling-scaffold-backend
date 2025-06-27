// ─────────────────────────────────────────────────────────────────────────────
// File: apps/health/api/handler.go
// ─────────────────────────────────────────────────────────────────────────────
package api

import (
	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/health"
	restfulspec "github.com/emicklei/go-restful-openapi/v2"
	"github.com/emicklei/go-restful/v3"
	healthgrpc "google.golang.org/grpc/health/grpc_health_v1"
)

// handler 是 Health RESTful Handler 的实现
type handler struct {
	service healthgrpc.HealthServer
	log     logger.Logger
}

// init 自动注册到 RESTful 应用容器
func init() {
	app.RegistryRESTfulApp(&handler{})
}

// Config 由框架调用：绑定日志和底层 gRPC 服务
func (h *handler) Config() error {
	const fn = "Health.Handler.Config"
	const lp = fn + " ---> "
	h.log = zap.L().Named(h.Name())
	h.service = app.GetInternalApp(health.AppName).(healthgrpc.HealthServer)
	return nil
}

// Name 返回该 Handler 对应的应用名
func (h *handler) Name() string {
	return health.AppName
}

// Version 返回 API 版本
func (h *handler) Version() string {
	return "v1"
}

// Registry 注册路由到 restful.Container
func (h *handler) Registry(ws *restful.WebService) {
	tags := []string{"健康检查"}
	ws.Route(ws.GET("/healthz").To(h.Check).
		Doc("查询服务健康状态").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Returns(200, "OK", Health{}))
}

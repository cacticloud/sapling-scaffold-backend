// ─────────────────────────────────────────────────────────────────────────────
// File: protocol/http.go
// ─────────────────────────────────────────────────────────────────────────────
package protocol

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
	auth "github.com/cacticloud/sapling-scaffold-backend/protocol/auth/restful"
	"github.com/cacticloud/sapling-scaffold-backend/swagger"
	restfulspec "github.com/emicklei/go-restful-openapi/v2"
	"github.com/emicklei/go-restful/v3"
)

// HTTPService 管理 go-restful 容器和底层 HTTP.Server
type HTTPService struct {
	container *restful.Container
	server    *http.Server
	log       logger.Logger
	conf      *conf.Config
}

// NewHTTPService 构造并初始化 HTTPService
func NewHTTPService() *HTTPService {
	const fn = "protocol.NewHTTPService"
	const lp = fn + " ---> "

	ctr := restful.DefaultContainer
	// Debug 级别记录容器创建
	zap.L().Named("HTTPService").Debugf("%s 使用 DefaultContainer", lp)

	// 1) CORS 中间件
	cors := restful.CrossOriginResourceSharing{
		AllowedHeaders: []string{"*"},
		AllowedDomains: []string{"*"},
		AllowedMethods: []string{"HEAD", "OPTIONS", "GET", "POST", "PUT", "PATCH", "DELETE"},
		CookiesAllowed: false,
		Container:      ctr,
	}
	ctr.Filter(cors.Filter)
	zap.L().Named("HTTPService").Debugf("%s CORS 中间件已注册", lp)

	// 2) AccessLog 中间件
	ctr.Filter(accessLogFilter)
	zap.L().Named("HTTPService").Debugf("%s AccessLog 中间件已注册", lp)

	// 3) Auth 中间件
	ctr.Filter(auth.NewHttpAuther().GoRestfulAuthFunc)
	zap.L().Named("HTTPService").Debugf("%s Auth 中间件已注册", lp)

	// 4) 构造底层 HTTP.Server
	addr := conf.C().App.HTTP.Addr()
	srv := &http.Server{
		Addr:              addr,
		Handler:           ctr,
		ReadHeaderTimeout: 60 * time.Second,
		ReadTimeout:       60 * time.Second,
		WriteTimeout:      60 * time.Second,
		IdleTimeout:       60 * time.Second,
		MaxHeaderBytes:    1 << 20,
	}
	zap.L().Named("HTTPService").Debugf("%s HTTP.Server 已创建，Addr=%s", lp, addr)

	return &HTTPService{
		container: ctr,
		server:    srv,
		log:       zap.L().Named("HTTPService"),
		conf:      conf.C(),
	}
}

// PathPrefix 返回统一的 RESTful 前缀，如 "/appName/api"
func (s *HTTPService) PathPrefix() string {
	return fmt.Sprintf("/%s/api", s.conf.App.Name)
}

// Start 加载所有路由、Swagger 并启动 HTTP 服务
func (s *HTTPService) Start() error {
	const fn = "HTTPService.Start"
	const lp = fn + " ---> "

	// 1) 装载所有注册的 RESTful 应用
	app.LoadRESTfulApp(s.PathPrefix(), s.container)
	loaded := strings.Join(app.LoadedRESTfulApp(), ", ")
	s.log.Infof("%s RESTful 应用加载完成：[%s]", lp, loaded)

	// 2) 注册 Swagger/OpenAPI
	sw := restfulspec.Config{
		WebServices:                   restful.RegisteredWebServices(),
		APIPath:                       "/apidocs.json",
		PostBuildSwaggerObjectHandler: swagger.Docs,
		DefinitionNameHandler: func(n string) string {
			// 过滤内部字段
			if n == "state" || n == "sizeCache" || n == "unknownFields" {
				return ""
			}
			return n
		},
	}
	s.container.Add(restfulspec.NewOpenAPIService(sw))
	s.log.Infof("%s Swagger 已启用，访问地址：http://%s%s", lp, s.conf.App.HTTP.Addr(), sw.APIPath)

	// 3) 启动 HTTP 服务
	s.log.Infof("%s 开始监听 HTTP 地址：%s", lp, s.server.Addr)
	if err := s.server.ListenAndServe(); err != nil {
		// 平滑停止
		if errors.Is(err, http.ErrServerClosed) {
			s.log.Infof("%s HTTP 服务已平滑关闭", lp)
			return nil
		}
		s.log.Errorf("%s HTTP 服务启动失败：%v", lp, err)
		return err
	}
	return nil
}

// Stop 优雅关闭 HTTP 服务，超时 30s
func (s *HTTPService) Stop() error {
	const fn = "HTTPService.Stop"
	const lp = fn + " ---> "

	s.log.Infof("%s 优雅关闭 HTTP 服务", lp)
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()
	if err := s.server.Shutdown(ctx); err != nil {
		s.log.Errorf("%s HTTP 服务关闭失败：%v", lp, err)
		return err
	}
	s.log.Infof("%s HTTP 服务已成功关闭", lp)
	return nil
}

// accessLogFilter 记录每次 HTTP 请求的结构化访问日志
func accessLogFilter(req *restful.Request, resp *restful.Response, chain *restful.FilterChain) {
	start := time.Now()
	chain.ProcessFilter(req, resp)
	duration := time.Since(start)

	log := zap.L().Named("AccessLog")
	log.Infow("HTTP 请求已完成",
		logger.NewAny("method", req.Request.Method),
		logger.NewAny("path", req.Request.URL.RequestURI()),
		logger.NewAny("status", resp.StatusCode()),
		logger.NewAny("duration", duration.String()), // e.g. "12.345ms"
		logger.NewAny("client_ip", extractClientIP(req.Request)),
	)
}

// extractClientIP 优先从 X-Forwarded-For 获取，否则使用 RemoteAddr
func extractClientIP(r *http.Request) string {
	if xff := r.Header.Get("X-Forwarded-For"); xff != "" {
		return strings.TrimSpace(strings.Split(xff, ",")[0])
	}
	if idx := strings.LastIndex(r.RemoteAddr, ":"); idx > 0 {
		return r.RemoteAddr[:idx]
	}
	return r.RemoteAddr
}

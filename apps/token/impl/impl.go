// apps/token/impl/service.go
package impl

import (
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token/provider"
	_ "github.com/cacticloud/sapling-scaffold-backend/apps/token/provider/all"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
	"google.golang.org/grpc"
	"xorm.io/xorm"
)

var (
	// svc 是全局唯一的 Token service 实例
	svc = NewService()
)

// service 实现了 token.RPCServer 接口
type service struct {
	db   *xorm.Engine  // 全局单例 DB
	log  logger.Logger // 结构化日志
	user user.Service  // 引用 user 服务，用于跨服务调用

	token.UnimplementedRPCServer
}

// NewService 创建并返回一个带有命名空间日志的 service 实例
func NewService() *service {
	return &service{
		log: zap.L().Named("TokenSRV"),
	}
}

// Config 注入依赖：初始化 DB、日志、子服务，并记录初始化耗时
func (s *service) Config() error {
	const fn, lp = "impl.token.Config", "impl.token.Config ---> "
	start := time.Now()
	s.log.Debugf("%s 开始初始化", lp)

	// 1) 复用全局单例 DB
	s.db = conf.DB()
	// 可选：根据需要打开 SQL 日志
	s.db.ShowSQL(conf.C().MySQL.ShowSQL)

	// 2) 初始化 user 服务引用
	s.user = app.GetInternalApp(user.AppName).(user.Service)

	// 3) 初始化所有 Token provider
	if err := provider.Init(); err != nil {
		s.log.Errorf("%s 初始化 token providers 失败: %v", lp, err)
		return err
	}

	s.log.Infof("%s 初始化完成，耗时=%s", lp, time.Since(start))
	return nil
}

// Name 返回当前服务名，用于框架内部注册
func (s *service) Name() string {
	return token.AppName
}

// Registry 向 gRPC Server 注册当前 service 实例
func (s *service) Registry(server *grpc.Server) {
	token.RegisterRPCServer(server, s)
}

// init 在包加载时注册 service
func init() {
	app.RegistryInternalApp(svc)
	app.RegistryGrpcApp(svc)
}

package impl

import (
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
	"google.golang.org/grpc"
	"xorm.io/xorm"
)

var (
	// Service 服务实例
	svr = NewService()
)

// service 实现了 user.RPCServer 接口
type service struct {
	log logger.Logger // 结构化日志
	db  *xorm.Engine  // 全局单例 DB

	user.UnimplementedRPCServer
}

// NewService 创建并返回一个命名为 UserSRV 的 service
func NewService() *service {
	return &service{
		log: zap.L().Named("UserSRV"),
	}
}

// Config 注入依赖：初始化 DB 并记录耗时
func (s *service) Config() error {
	const fn = "impl.service.Config"
	const lp = fn + " ---> "

	start := time.Now()
	s.log.Debugf("%s 开始初始化 Service 配置", lp)

	s.db = conf.DB()

	s.log.Infof("%s 数据库连接就绪，耗时=%s", lp, time.Since(start))
	return nil
}

// Name 返回当前服务名称，用于框架内部注册
func (s *service) Name() string {
	return user.AppName
}

// Registry 向 gRPC Server 注册当前 service
func (s *service) Registry(server *grpc.Server) {
	user.RegisterRPCServer(server, s)
}

func init() {
	app.RegistryInternalApp(svr)
	app.RegistryGrpcApp(svr)
}

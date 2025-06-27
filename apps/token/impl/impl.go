package impl

import (
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
	// Service 服务实例
	svr = &service{}
)

type service struct {
	db *xorm.Engine
	token.UnimplementedRPCServer
	log logger.Logger

	// policy  policy.Service
	// ns      namespace.Service
	// checker security.Checker
	user user.Service
}

func (s *service) Config() error {
	// var err error
	db := conf.C().MySQL.GetDB()
	s.db = db
	s.log = zap.L().Named(s.Name())
	// s.code = app.GetInternalApp(code.AppName).(code.Service)
	// s.ns = app.GetInternalApp(namespace.AppName).(namespace.Service)
	// s.policy = app.GetInternalApp(policy.AppName).(policy.Service)
	s.user = app.GetInternalApp(user.AppName).(user.Service)

	// s.checker, err = security.NewChecker()
	// if err != nil {
	//	return fmt.Errorf("new checker error, %v", err)
	// }

	// 初始化所有的auth provider
	if err := provider.Init(); err != nil {
		return err
	}

	return nil
}

func (s *service) Name() string {
	return token.AppName
}

func (s *service) Registry(server *grpc.Server) {
	token.RegisterRPCServer(server, svr)
}

func init() {
	app.RegistryInternalApp(svr)
	app.RegistryGrpcApp(svr)
}

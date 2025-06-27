package impl

import (
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
	svr = &service{}
)

type service struct {
	log logger.Logger
	db  *xorm.Engine

	user.UnimplementedRPCServer
}

func (s *service) Config() error {
	db := conf.C().MySQL.GetDB()

	s.db = db
	s.log = zap.L().Named(s.Name())
	// s.domain = app.GetInternalApp(domain.AppName).(domain.Service)
	// s.policy = app.GetInternalApp(policy.AppName).(policy.Service)
	return nil
}

func (s *service) Name() string {
	return user.AppName
}

func (s *service) Registry(server *grpc.Server) {
	user.RegisterRPCServer(server, svr)
}

func init() {
	app.RegistryInternalApp(svr)
	app.RegistryGrpcApp(svr)
}

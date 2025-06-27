package impl

import (
	"github.com/cacticloud/cactikit/app"
	healthapp "github.com/cacticloud/sapling-scaffold-backend/apps/health"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	healthgrpc "google.golang.org/grpc/health/grpc_health_v1"
)

var (
	// Service 服务实例
	svr = &impl{Server: health.NewServer()}
)

type impl struct {
	*health.Server
}

func (i *impl) Config() error {
	return nil
}

func (i *impl) Name() string {
	return healthapp.AppName
}

func (i *impl) Registry(server *grpc.Server) {
	healthgrpc.RegisterHealthServer(server, svr)
}

func init() {
	app.RegistryInternalApp(svr)
	app.RegistryGrpcApp(svr)
}

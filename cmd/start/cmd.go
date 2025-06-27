package start

import (
	"os"
	"os/signal"
	"syscall"

	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/protocol"
	"github.com/spf13/cobra"
)

const sigBufSize = 1

// Cmd 启动 API 服务并优雅停机
var Cmd = &cobra.Command{
	Use:   "start",
	Short: "启动 API 服务",
	RunE:  runE,
}

func init() {
	Cmd.PersistentFlags().StringP("dummy", "d", "", "占位参数")
}

func runE(cmd *cobra.Command, args []string) error {
	const fn, lp = "start.RunE", "start.RunE ---> "
	log := zap.L().Named("CLI")

	// 捕获系统信号
	sigCh := make(chan os.Signal, sigBufSize)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)

	// 构建并启动 HTTPService
	svc := &service{http: protocol.NewHTTPService()}
	log.Infof("%s 服务实例已创建", lp)

	go svc.waitSignal(sigCh)
	return svc.start()
}

type service struct{ http *protocol.HTTPService }

func (s *service) start() error {
	const fn, lp = "service.start", "service.start ---> "
	log := zap.L().Named("CLI")

	log.Infof("%s 正在启动 HTTP 服务", lp)
	return s.http.Start()
}

func (s *service) waitSignal(ch chan os.Signal) {
	const fn, lp = "service.waitSignal", "service.waitSignal ---> "
	log := zap.L().Named("CLI")

	sig := <-ch
	log.Infof("%s 收到停止信号：%v，即将优雅关闭", lp, sig)
	if err := s.http.Stop(); err != nil {
		log.Errorf("%s 优雅关闭失败：%v", lp, err)
	}
}

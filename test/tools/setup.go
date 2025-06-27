package tools

import (
	"os"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/cache"
	"github.com/cacticloud/cactikit/cache/memory"
	"github.com/cacticloud/cactikit/logger/zap"
	// 注册所有服务
	_ "github.com/cacticloud/sapling-scaffold-backend/apps"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
)

func DevelopmentSetup() {
	// 初始化日志实例
	zap.DevelopmentSetup()

	// 初始化配置, 提前配置好/etc/unit_test.env
	err := conf.LoadConfigFromToml("/Users/wunai/Study/Go/src/gitlab.myinterest.top/internal-project/sapling-scaffold/sapling-scaffold-backend/etc/config.toml")
	if err != nil {
		panic(err)
	}

	// 初始化缓存
	ins := memory.NewCache(conf.C().Cache.Memory)
	cache.SetGlobal(ins)

	// 初始化全局app
	if err := app.InitAllApp(); err != nil {
		panic(err)
	}

}

func AccessToken() string {
	return os.Getenv("MCENTER_ACCESS_TOKEN")
}

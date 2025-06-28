package bootstrap

import (
	"errors"
	"strings"
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/cache"
	"github.com/cacticloud/cactikit/cache/memory"
	"github.com/cacticloud/cactikit/cache/redis"
	"github.com/cacticloud/cactikit/logger/zap"
	_ "github.com/cacticloud/sapling-scaffold-backend/apps"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
	"github.com/spf13/cobra"
)

var (
	// 由 root 或 start 注入的值
	ConfType *string
	ConfFile *string
	ShowVer  *bool
)

// Initialize 执行全局初始化：配置→日志→缓存→模块 注册
func Initialize(cmd *cobra.Command, args []string) error {
	const fn, lp = "bootstrap.Initialize", "bootstrap.Initialize ---> "
	log := zap.L().Named("INIT")

	t0 := time.Now()
	log.Infof("%s 开始全局初始化", lp)

	// 1) 配置
	switch strings.ToLower(*ConfType) {
	case "file":
		if err := conf.LoadConfigFromToml(*ConfFile); err != nil {
			log.Errorf("%s 加载 TOML 配置失败: %v", lp, err)
			return err
		}
	case "env":
		if err := conf.LoadConfigFromEnv(); err != nil {
			log.Errorf("%s 加载 Env 配置失败: %v", lp, err)
			return err
		}
	default:
		err := errors.New("未知配置来源: " + *ConfType)
		log.Error(lp + err.Error())
		return err
	}
	log.Infof("%s 配置加载完成，耗时=%s", lp, time.Since(t0))

	// 2) 日志
	t0 = time.Now()
	lc := conf.C().Log
	level, err := zap.NewLevel(lc.Level)
	if err != nil {
		level = zap.InfoLevel
	}
	cfg := zap.DefaultConfig()
	cfg.Level = level
	to := strings.ToLower(lc.To)
	cfg.ToStderr = to == "stdout" || to == "all"
	cfg.ToFiles = to == "file" || to == "all"
	switch strings.ToLower(lc.ConsoleFormat) {
	case "json":
		cfg.JSON, cfg.Color = true, false
	case "color":
		cfg.JSON, cfg.Color = false, true
	default:
		cfg.JSON, cfg.Color = false, false
	}
	if err := zap.Configure(cfg); err != nil {
		log.Errorf("%s 日志初始化失败: %v", lp, err)
		return err
	}
	log.Infof("%s 日志初始化完成，耗时=%s", lp, time.Since(t0))

	// 3) 缓存
	t0 = time.Now()
	cc := conf.C().Cache
	switch strings.ToLower(cc.Type) {
	case "redis":
		cache.SetGlobal(redis.NewCache(cc.Redis))
		log.Infof("%s Redis 缓存已启用", lp)
	default:
		cache.SetGlobal(memory.NewCache(cc.Memory))
		log.Infof("%s 内存缓存已启用", lp)
	}
	log.Infof("%s 缓存初始化完成，耗时=%s", lp, time.Since(t0))

	// 4) 模块
	t0 = time.Now()
	if err := app.InitAllApp(); err != nil {
		log.Errorf("%s 模块注册失败: %v", lp, err)
		return err
	}
	log.Infof("%s 模块注册完成，耗时=%s", lp, time.Since(t0))

	log.Infof("%s 全局初始化完成，总耗时=%s", lp, time.Since(t0))
	return nil
}

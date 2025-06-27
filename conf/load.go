// conf/load.go
package conf

import (
	"sync"
	"time"

	"github.com/BurntSushi/toml"
	"github.com/caarlos0/env/v6"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/pkg/errors"
)

var (
	global     *Config
	configOnce sync.Once
)

// LoadConfigFromToml 从 TOML 文件加载配置，仅首次调用生效
func LoadConfigFromToml(path string) error {
	const fn = "conf.LoadConfigFromToml"
	const lp = fn + " ---> "
	log := zap.L().Named("CONF")
	start := time.Now()

	var err error
	configOnce.Do(func() {
		log.Infof("%s 开始解析 TOML 文件：%s", lp, path)
		cfg := defaultConfig()
		if _, err = toml.DecodeFile(path, &cfg); err != nil {
			log.Errorf("%s 解析失败：%v", lp, err)
			err = errors.Wrap(err, lp+"解析 TOML 失败")
			return
		}
		global = &cfg
		log.Infof("%s 解析 TOML 成功，耗时=%s", lp, time.Since(start))
	})
	return err
}

// LoadConfigFromEnv 从环境变量加载配置，仅首次调用生效
func LoadConfigFromEnv() error {
	const fn = "conf.LoadConfigFromEnv"
	const lp = fn + " ---> "
	log := zap.L().Named("CONF")
	start := time.Now()

	var err error
	configOnce.Do(func() {
		log.Infof("%s 开始解析环境变量", lp)
		cfg := defaultConfig()
		if err = env.Parse(&cfg); err != nil {
			log.Errorf("%s 解析失败：%v", lp, err)
			err = errors.Wrap(err, lp+"解析 Env 失败")
			return
		}
		global = &cfg
		log.Infof("%s 解析环境变量成功，耗时=%s", lp, time.Since(start))
	})
	return err
}

// C 返回已加载配置，未初始化时 panic
func C() *Config {
	if global == nil {
		panic("conf: 配置未初始化，请先调用 LoadConfigFromToml 或 LoadConfigFromEnv")
	}
	return global
}

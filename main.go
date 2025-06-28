package main

import (
	"fmt"
	"os"

	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/cmd"
)

func main() {
	// 1) 最先配置基础日志
	zapCfg := zap.DefaultConfig()
	zapCfg.ToStderr = true // 输出到控制台
	zapCfg.ToFiles = false // 不输出文件
	zapCfg.Level = zap.DebugLevel
	if err := zap.Configure(zapCfg); err != nil {
		fmt.Fprintf(os.Stderr, "初始化基础日志失败: %v\n", err)
		os.Exit(1)
	}

	// 2) 启动 Cobra
	cmd.Execute()
}

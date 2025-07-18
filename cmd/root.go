package cmd

import (
	"github.com/cacticloud/sapling-scaffold-backend/cmd/bootstrap"
	"github.com/cacticloud/sapling-scaffold-backend/cmd/start"
	"github.com/cacticloud/sapling-scaffold-backend/version"
	"github.com/spf13/cobra"
)

var (
	confType string
	confFile string
	showVer  bool

	RootCmd = &cobra.Command{
		Use:   "sapling-scaffold-backend",
		Short: "后台微服务 API",
		Long:  "基于 Sapling Scaffold 的后台微服务 API 服务",
		RunE: func(cmd *cobra.Command, args []string) error {
			if showVer {
				cmd.Println(version.FullVersion())
				return nil
			}
			return cmd.Help()
		},
	}
)

func init() {
	// 允许子命令后置 flag
	RootCmd.TraverseChildren = true

	RootCmd.PersistentFlags().StringVarP(&confType, "config-type", "t", "file", "配置来源: file|env")
	RootCmd.PersistentFlags().StringVarP(&confFile, "config-file", "f", "etc/config.toml", "配置文件路径")
	RootCmd.PersistentFlags().BoolVarP(&showVer, "version", "v", false, "显示版本信息")

	// 把持久化 flag 的地址给 bootstrap
	bootstrap.ConfType = &confType
	bootstrap.ConfFile = &confFile
	bootstrap.ShowVer = &showVer

	RootCmd.AddCommand(start.Cmd)
}

func Execute() {
	if err := RootCmd.Execute(); err != nil {
		panic(err)
	}
}

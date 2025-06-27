package all

import (
	// 注册所有GRPC服务模块, 暴露给框架GRPC服务器加载,用于内部依赖， 注意 导入有先后顺序
	_ "github.com/cacticloud/sapling-scaffold-backend/apps/token/impl"
	_ "github.com/cacticloud/sapling-scaffold-backend/apps/user/impl"
)

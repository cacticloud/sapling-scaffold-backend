package token

import "github.com/cacticloud/cactikit/exception"

var (
	// 当请求头缺失或格式不正确时，返回中文提示
	ErrUnauthorized = exception.NewUnauthorized(
		"需要认证头，格式：%v: Bearer ${access_token}",
		ACCESS_TOKEN_HEADER_KEY,
	)
)

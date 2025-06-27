package token

import "github.com/cacticloud/cactikit/exception"

var (
	ErrUnauthorized = exception.NewUnauthorized("Auth Header Required, Format: %v: Bearer ${access_token}", ACCESS_TOKEN_HEADER_KEY)
)

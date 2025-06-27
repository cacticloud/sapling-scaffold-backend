package provider

import (
	"context"
	"fmt"

	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
)

var (
	// m is a map from scheme to issuer.
	m = make(map[token.GRANT_TYPE]Issuer)
)

// 颁发器, 可以颁发Token或者验证码
type Issuer interface {
	Init() error
	GrantType() token.GRANT_TYPE
	TokenIssuer
}

// 访问令牌颁发器
type TokenIssuer interface {
	IssueToken(context.Context, *token.IssueTokenRequest) (*token.Token, error)
}

func GetTokenIssuer(gt token.GRANT_TYPE) TokenIssuer {
	if v, ok := m[gt]; ok {
		return v
	}

	return nil
}

// 注册令牌颁发器
func Registe(i Issuer) {
	m[i.GrantType()] = i
}

func Init() error {
	for k, v := range m {
		if err := v.Init(); err != nil {
			return fmt.Errorf("init %v issuer error", k)
		}
	}

	return nil
}

package token

import context "context"

type Service interface {
	// 颁发Token
	IssueToken(context.Context, *IssueTokenRequest) (*Token, error)
	// 撤销Token
	RevolkToken(context.Context, *RevolkTokenRequest) (*Token, error)

	// 查询Token详情
	DescribeToken(context.Context, *DescribeTokenRequest) (*Token, error)
	// RPC
	RPCServer
}

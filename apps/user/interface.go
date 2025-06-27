package user

import "context"

const (
	AppName = "user"
)

type Service interface {
	CreateUser(context.Context, *UpdateUserRequest) (*UpdateUserRequest, error)
	DeleteUser(context.Context, *DeleteUserRequest) (*UserSet, error)
	UpdateUser(context.Context, *UpdateUserRequest) (*DescribeUserResponse, error)
	UpdatePassword(context.Context, *UpdatePasswordRequest) (*User, error)
	ResetPassword(context.Context, *ResetPasswordRequest) (*User, error)
	RPCServer
}

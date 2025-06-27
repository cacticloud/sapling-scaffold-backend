package impl

import (
	"context"
	"fmt"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	"github.com/cacticloud/sapling-scaffold-backend/utils"
)

var (
	userTableName     = "mcenter_user"
	userRoleTableName = "mcenter_user_role"
)

func (s *service) CreateUser(ctx context.Context, req *user.UpdateUserRequest) (*user.UpdateUserRequest, error) {
	u, err := user.New(req)
	if err != nil {
		return nil, err
	}
	// 如果是管理员创建的账号需要用户自己重置密码
	// if req.CreateBy.IsIn(user.CREATE_BY_ADMIN) {
	//	u.Password.SetNeedReset("admin created user need reset when first login")
	// }

	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		return nil, exception.NewInternalServerError("user save begin error, %v",
			err)
	}
	if _, err := session.Table(userTableName).Insert(u.Spec); err != nil {
		return nil, exception.NewInternalServerError("inserted user(%v) error, %v", u.Spec.Username, err)
	}

	if len(req.RoleIds) > 0 {
		userRole := make([]user.UserRole, 0, len(req.RoleIds))
		for _, roleId := range req.RoleIds {
			userRole = append(userRole, user.UserRole{
				RoleId: roleId,
				UserId: req.Spec.Id,
			})
		}
		if _, err := session.Table(userRoleTableName).Insert(userRole); err != nil {
			return nil, exception.NewInternalServerError("inserted role_permission(%v) error, %v", userRole, err)
		}
	}
	return u, session.Commit()
}

// QueryUser 查询用户列表
func (s *service) QueryUser(ctx context.Context, req *user.QueryUserRequest) (*user.UserSet, error) {
	set := user.NewUserSet()
	countUser := user.NewDefaultUser()

	if len(req.UserIds) > 0 {

		err := s.db.Table(userTableName).In("id", req.UserIds).Find(&set.Items)
		if err != nil {
			return nil, exception.NewInternalServerError(err.Error())
		}

		total, err := s.db.Table(userTableName).In("id", req.UserIds).Count(countUser)
		if err != nil {
			return nil, exception.NewInternalServerError(err.Error())
		}
		set.Total = total
		return set, nil
	}

	if req.Keywords != "" {
		err := s.db.Table(userTableName).Where(
			"username LIKE ? OR remark LIKE ? ",
			"%"+req.Keywords+"%", "%"+req.Keywords+"%",
		).Desc("create_at").Limit(int(req.Page.PageSize), int(req.Page.PageNumber-1)*int(req.Page.PageSize)).Find(&set.Items)
		if err != nil {
			return nil, nil
		}

		// 获取total SELECT COUNT(*) FROMT t Where ....
		total, err := s.db.Table(userTableName).Where(
			"username LIKE ? OR remark LIKE ? ",
			"%"+req.Keywords+"%", "%"+req.Keywords+"%",
		).Count(countUser)
		if err != nil {
			return nil, exception.NewInternalServerError(err.Error())
		}
		set.Total = total
		return set, nil
	}

	err := s.db.Table(userTableName).Desc("create_at").Limit(int(req.Page.PageSize), int(req.Page.PageNumber-1)*int(req.Page.PageSize)).Find(&set.Items)
	if err != nil {
		return nil, nil
	}

	// 获取total SELECT COUNT(*) FROM  Where ....
	total, err := s.db.Table(userTableName).Count(countUser)
	if err != nil {
		return nil, exception.NewInternalServerError(err.Error())
	}
	set.Total = total
	return set, nil
}

// DescribeUser 查询用户详情
func (s *service) DescribeUser(ctx context.Context, req *user.DescribeUserRequest) (*user.DescribeUserResponse, error) {
	var (
		err error
	)
	ins := user.NewDefaultUser()
	switch req.DescribeBy {
	case user.DESCRIBE_BY_USER_ID:
		_, err = s.db.Table(userTableName).Where("id = ?", req.Id).Get(ins)
		if err != nil {
			return nil, exception.NewInternalServerError("describe user ID error, %v", err.Error())
		}
	// case user.DESCRIBE_BY_FEISHU_USER_ID:
	// 	return nil, exception.NewBadRequest("describe by feishu not impl")
	case user.DESCRIBE_BY_USER_NAME:
		_, err = s.db.Table(userTableName).Where("username = ?", req.Username).Get(ins)
		fmt.Println(ins, "-----ins----->", req.Username)
		if err != nil {
			return nil, exception.NewInternalServerError("describe username error, %v", err.Error())
		}
	default:
		return nil, exception.NewBadRequest("user unknown describe by %v", req.DescribeBy)
	}

	resp := user.NewDescribeUserResponse()
	resp.User = ins

	err = s.db.Table(userRoleTableName).Where("user_id = ?", req.Id).Cols("role_id").Find(&resp.RoleIds)
	if err != nil {
		return nil, exception.NewInternalServerError("describe user should role error: %v", err.Error())
	}

	return resp, nil
}

func (s *service) UpdateUser(ctx context.Context, req *user.UpdateUserRequest) (*user.DescribeUserResponse, error) {
	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		return nil, exception.NewInternalServerError("user update begin error, %v", err)
	}

	ins, err := s.DescribeUser(ctx, user.NewDescriptUserRequestById(utils.Int64ToString(req.Spec.Id)))
	if err != nil {
		return nil, exception.NewBadRequest(err.Error())
	}

	ins.Update(req)
	_, err = session.Table(userTableName).Where("id = ?", req.Spec.Id).AllCols().Update(ins.User.Spec)

	if err != nil {
		return nil, exception.NewBadRequest("update user %v failed", err)
	}

	if len(req.RoleIds) > 0 {
		if _, err := session.Table(userRoleTableName).In("user_id", req.Spec.Id).Delete(); err != nil {
			return nil, exception.NewInternalServerError("delete mcenter_user_role(%v) error: %v", req.RoleIds, err.Error())
		}
		userRole := make([]user.UserRole, 0, len(req.RoleIds))
		for _, roleId := range req.RoleIds {
			userRole = append(userRole, user.UserRole{
				RoleId: roleId,
				UserId: req.Spec.Id,
			})
		}
		fmt.Println(userRole, "--------userRole------->")
		if _, err := session.Table(userRoleTableName).Insert(userRole); err != nil {
			return nil, exception.NewInternalServerError("inserted user_role(%v) error, %v", userRole, err)
		}
	}
	return ins, session.Commit()
}

func (s *service) DeleteUser(ctx context.Context, req *user.DeleteUserRequest) (*user.UserSet, error) {
	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		return nil, exception.NewInternalServerError("user delete begin error, %v", err)
	}
	queryReq := user.NewQueryUserRequest()
	queryReq.UserIds = req.UserIds
	set, err := s.QueryUser(ctx, queryReq)
	if err != nil {
		return nil, exception.NewInternalServerError("query user error, %v", err)
	}

	var noExist []int64
	for _, uid := range req.UserIds {
		if !set.HasUser(uid) {
			noExist = append(noExist, uid)
		}
	}
	if len(noExist) > 0 {
		return nil, exception.NewBadRequest("users id %v not found", req.UserIds)
	}

	if _, err = session.Table(userRoleTableName).In("user_id", queryReq.UserIds).Delete(); err != nil {
		return nil, exception.NewInternalServerError("delete mcenter_user_role(%v) error: %v", queryReq.UserIds, err.Error())
	}

	if _, err := session.Table(userTableName).In("id", queryReq.UserIds).Delete(); err != nil {
		return nil, exception.NewBadRequest("delete user %v failed", err)
	}

	return set, session.Commit()
}

// UpdatePassword 修改用户密码, 用户需要知道原先密码
func (s *service) UpdatePassword(ctx context.Context, req *user.UpdatePasswordRequest) (*user.User, error) {
	return nil, nil
}

// ResetPassword 重置密码, 无需知道原先密码, 主账号执行
func (s *service) ResetPassword(ctx context.Context, req *user.ResetPasswordRequest) (*user.User, error) {
	return nil, nil
}

func (s *service) GetUserRoles(ctx context.Context, req *user.GetUserRoleRequest) (roleIds *user.GetUserRoleResponse, err error) {
	resp := user.NewGetUserRoleResponse()
	switch req.DescribeBy {
	case user.DESCRIBE_BY_USER_ID:
		err = s.db.Table(userRoleTableName).Where("user_id = ?", req.Id).Cols("role_id").Find(&resp.RoleIds)
		if err != nil {
			return nil, exception.NewInternalServerError("query user should roleIds error: %v", err.Error())
		}
	case user.DESCRIBE_BY_USER_NAME:
		return nil, exception.NewBadRequest("query userRoles by username not impl")
	}

	if len(resp.RoleIds) == 0 {
		return nil, exception.NewBadRequest("query user should roleIds is nil")
	}
	return resp, nil
}

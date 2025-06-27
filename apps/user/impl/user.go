package impl

import (
	"context"
	"strconv"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
)

// 表名常量
const (
	userTableName     = "sapling_scaffold_user"
	userRoleTableName = "sapling_scaffold_user_role"
)

// CreateUser 创建新用户。
// 参数:
//
//	ctx 上下文
//	req 包含用户信息的 UpdateUserRequest
//
// 返回:
//
//	*user.UpdateUserRequest 保存后带主键的对象
//	error 出错时返回非 nil
func (s *service) CreateUser(ctx context.Context, req *user.UpdateUserRequest) (*user.UpdateUserRequest, error) {
	const fn = "Service.CreateUser"
	const lp = fn + " ---> "

	s.log.Infof("%s开始创建用户 username=%s", lp, req.Spec.Username)
	entity, err := user.New(req)
	if err != nil {
		s.log.Warnf("%s请求参数校验失败: %v", lp, err)
		return nil, err
	}

	s.log.Debugf("%s实体构造完成: %+v", lp, entity.Spec)
	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		s.log.Errorf("%s开启事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("创建用户失败：%v", err)
	}

	if _, err := session.Table(userTableName).Insert(entity.Spec); err != nil {
		s.log.Errorf("%s插入用户失败: %v", lp, err)
		return nil, exception.NewInternalServerError("创建用户失败：%v", err)
	}

	if err := session.Commit(); err != nil {
		s.log.Errorf("%s提交事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("创建用户失败：%v", err)
	}

	s.log.Infof("%s创建成功 id=%d", lp, entity.Spec.Id)
	return entity, nil
}

// QueryUser 分页或条件查询用户列表。
// 参数:
//
//	ctx 上下文
//	req 包含分页、关键词或 ID 列表过滤的 QueryUserRequest
//
// 返回:
//
//	*user.UserSet 查询结果（Items + Total）
//	error 出错时返回
func (s *service) QueryUser(ctx context.Context, req *user.QueryUserRequest) (*user.UserSet, error) {
	const fn = "Service.QueryUser"
	const lp = fn + " ---> "

	s.log.Debugf("%s入参 filters=%+v", lp, req)
	set := user.NewUserSet()
	counter := user.NewDefaultUser()

	// 按 ID 列表批量查询
	if len(req.UserIds) > 0 {
		s.log.Debugf("%s按 ID 列表查询: %v", lp, req.UserIds)
		if err := s.db.Table(userTableName).In("id", req.UserIds).Find(&set.Items); err != nil {
			s.log.Errorf("%s按 ID 查询失败: %v", lp, err)
			return nil, exception.NewInternalServerError("查询用户失败：%v", err)
		}
		total, err := s.db.Table(userTableName).In("id", req.UserIds).Count(counter)
		if err != nil {
			s.log.Errorf("%s统计总数失败: %v", lp, err)
			return nil, exception.NewInternalServerError("查询用户失败：%v", err)
		}
		set.Total = total
		s.log.Debugf("%s按 ID 查询完成 count=%d", lp, total)
		return set, nil
	}

	// 关键词搜索
	if req.Keywords != "" {
		like := "%" + req.Keywords + "%"
		s.log.Debugf("%s关键词搜索: %s", lp, req.Keywords)
		if err := s.db.Table(userTableName).
			Where("username LIKE ? OR remark LIKE ?", like, like).
			Desc("create_at").
			Limit(int(req.Page.PageSize), int(req.Page.PageNumber-1)*int(req.Page.PageSize)).
			Find(&set.Items); err != nil {
			s.log.Errorf("%s关键词查询失败: %v", lp, err)
			return nil, exception.NewInternalServerError("查询用户失败：%v", err)
		}
		total, err := s.db.Table(userTableName).
			Where("username LIKE ? OR remark LIKE ?", like, like).
			Count(counter)
		if err != nil {
			s.log.Errorf("%s统计总数失败: %v", lp, err)
			return nil, exception.NewInternalServerError("查询用户失败：%v", err)
		}
		set.Total = total
		s.log.Debugf("%s关键词查询完成 count=%d", lp, total)
		return set, nil
	}

	// 默认分页
	s.log.Debugf("%s默认分页 page=%d size=%d", lp, req.Page.PageNumber, req.Page.PageSize)
	if err := s.db.Table(userTableName).
		Desc("create_at").
		Limit(int(req.Page.PageSize), int(req.Page.PageNumber-1)*int(req.Page.PageSize)).
		Find(&set.Items); err != nil {
		s.log.Errorf("%s分页查询失败: %v", lp, err)
		return nil, exception.NewInternalServerError("查询用户失败：%v", err)
	}
	total, err := s.db.Table(userTableName).Count(counter)
	if err != nil {
		s.log.Errorf("%s统计总数失败: %v", lp, err)
		return nil, exception.NewInternalServerError("查询用户失败：%v", err)
	}
	set.Total = total
	s.log.Debugf("%s分页查询完成 count=%d", lp, total)
	return set, nil
}

// DescribeUser 查询单个用户详情。
// 参数:
//
//	ctx 上下文
//	req 描述请求，支持按 ID 或用户名查询（ID 从字符串转换）
//
// 返回:
//
//	*user.DescribeUserResponse 包含用户信息
//	error 出错时返回
func (s *service) DescribeUser(ctx context.Context, req *user.DescribeUserRequest) (*user.DescribeUserResponse, error) {
	const fn = "Service.DescribeUser"
	const lp = fn + " ---> "

	// 将 DescribeBy 和原始值映射便于日志
	valueMap := map[user.DESCRIBE_BY]string{
		user.DESCRIBE_BY_USER_ID:   req.Id,
		user.DESCRIBE_BY_USER_NAME: req.Username,
	}
	s.log.Debugf("%s开始查询详情 DescribeBy=%v value=%s", lp, req.DescribeBy, valueMap[req.DescribeBy])

	ins := user.NewDefaultUser()
	var has bool
	var err error

	switch req.DescribeBy {
	case user.DESCRIBE_BY_USER_ID:
		// ID 是 string，需要先转换为 int64
		idInt, parseErr := strconv.ParseInt(req.Id, 10, 64)
		if parseErr != nil {
			s.log.Warnf("%s无效的用户 ID 格式: %s", lp, req.Id)
			return nil, exception.NewBadRequest("无效的用户 ID：%s", req.Id)
		}
		has, err = s.db.Table(userTableName).
			Where("id = ?", idInt).
			Get(ins)

	case user.DESCRIBE_BY_USER_NAME:
		has, err = s.db.Table(userTableName).
			Where("username = ?", req.Username).
			Get(ins)

	default:
		s.log.Warnf("%s未知查询类型: %v", lp, req.DescribeBy)
		return nil, exception.NewBadRequest("未知的查询条件：%v", req.DescribeBy)
	}

	if err != nil {
		s.log.Errorf("%s数据库查询失败: %v", lp, err)
		return nil, exception.NewInternalServerError("查询用户详情失败：%v", err)
	}
	if !has {
		s.log.Warnf("%s未找到用户: %s", lp, valueMap[req.DescribeBy])
		return nil, exception.NewBadRequest("用户不存在")
	}

	s.log.Debugf("%s查询到用户: %+v", lp, ins)
	resp := user.NewDescribeUserResponse()
	resp.User = ins
	s.log.Infof("%s查询完成 id=%v", lp, valueMap[req.DescribeBy])
	return resp, nil
}

// UpdateUser 更新用户及其角色。
// 参数:
//
//	ctx 上下文
//	req 更新请求，包含 Spec 和 RoleIds
//
// 返回:
//
//	*user.DescribeUserResponse 更新后的详情
//	error 出错时返回
func (s *service) UpdateUser(ctx context.Context, req *user.UpdateUserRequest) (*user.DescribeUserResponse, error) {
	const fn = "Service.UpdateUser"
	const lp = fn + " ---> "

	s.log.Infof("%s开始更新用户 id=%d", lp, req.Spec.Id)
	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		s.log.Errorf("%s开启事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("更新用户失败：%v", err)
	}

	// 查询原始数据
	idStr := strconv.FormatInt(req.Spec.Id, 10)
	old, err := s.DescribeUser(ctx, user.NewDescriptUserRequestById(idStr))
	if err != nil {
		s.log.Warnf("%s查询旧记录失败: %v", lp, err)
		return nil, exception.NewBadRequest("无效的用户 ID：%s", idStr)
	}

	// 应用更新
	old.Update(req)
	if _, err := session.Table(userTableName).
		Where("id = ?", req.Spec.Id).
		AllCols().
		Update(old.User.Spec); err != nil {
		s.log.Errorf("%s更新用户失败: %v", lp, err)
		return nil, exception.NewInternalServerError("更新用户失败：%v", err)
	}

	if err := session.Commit(); err != nil {
		s.log.Errorf("%s提交事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("更新用户失败：%v", err)
	}
	s.log.Infof("%s更新完成 id=%d", lp, req.Spec.Id)
	return old, nil
}

// DeleteUser 删除一批用户及其角色。
// 参数:
//
//	ctx 上下文
//	req DeleteUserRequest 包含要删除的 UserIds 列表
//
// 返回:
//
//	*user.UserSet 被删除的用户集
//	error 出错时返回
func (s *service) DeleteUser(ctx context.Context, req *user.DeleteUserRequest) (*user.UserSet, error) {
	const fn = "Service.DeleteUser"
	const lp = fn + " ---> "

	s.log.Infof("%s开始删除用户 ids=%v", lp, req.UserIds)
	session := s.db.NewSession()
	defer session.Close()
	if err := session.Begin(); err != nil {
		s.log.Errorf("%s开启事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("删除用户失败：%v", err)
	}

	// 验证存在性
	set, err := s.QueryUser(ctx, &user.QueryUserRequest{UserIds: req.UserIds})
	if err != nil {
		s.log.Errorf("%s查询用户失败: %v", lp, err)
		return nil, exception.NewInternalServerError("删除用户失败：%v", err)
	}
	var missing []int64
	for _, id := range req.UserIds {
		if !set.HasUser(id) {
			missing = append(missing, id)
		}
	}
	if len(missing) > 0 {
		s.log.Warnf("%s部分用户不存在: %v", lp, missing)
		return nil, exception.NewBadRequest("以下用户不存在：%v", missing)
	}

	// 删除用户
	if _, err := session.Table(userTableName).
		In("id", req.UserIds).
		Delete(); err != nil {
		s.log.Errorf("%s删除用户失败: %v", lp, err)
		return nil, exception.NewInternalServerError("删除用户失败：%v", err)
	}

	if err := session.Commit(); err != nil {
		s.log.Errorf("%s提交事务失败: %v", lp, err)
		return nil, exception.NewInternalServerError("删除用户失败：%v", err)
	}
	s.log.Infof("%s删除完成 ids=%v", lp, req.UserIds)
	return set, nil
}

// ResetPassword 实现 user.Service 接口中的方法槽位，暂时返回未实现错误
func (s *service) ResetPassword(ctx context.Context, req *user.ResetPasswordRequest) (*user.User, error) {
	const fn = "Service.ResetPassword"
	const lp = fn + " ---> "

	s.log.Warnf("%s未实现 ResetPassword 方法", lp)
	return nil, exception.NewInternalServerError("重置密码功能暂未实现")
}

func (s *service) UpdatePassword(ctx context.Context, req *user.UpdatePasswordRequest) (*user.User, error) {
	const fn = "Service.UpdatePassword"
	const lp = fn + " ---> "

	s.log.Warnf("%s未实现 UpdatePassword 方法", lp)
	// 返回一个“功能未实现”的中文错误
	return nil, exception.NewInternalServerError("修改密码功能暂未实现")
}

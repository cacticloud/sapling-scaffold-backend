package impl_test

import (
	"fmt"
	"testing"

	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
)

// func TestCreateSupperUser(t *testing.T) {
// 	req := user.NewCreateUserRequest()
// 	req.Domain = domain.DEFAULT_DOMAIN
// 	req.Username = "root"
// 	req.Password = "123456"
// 	req.Type = user.TYPE_SUPPER
// 	r, err := impl.CreateUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r)
// }

func TestCreateSupperUser(t *testing.T) {
	// 1. 先构造一个 CreateUserRequest
	createReq := user.NewCreateUserRequest()
	createReq.Domain = "default"
	createReq.Username = "root"
	createReq.Password = "123456"
	createReq.Type = user.TYPE_SUPPER

	// 2. 包装成 UpdateUserRequest
	updateReq := &user.UpdateUserRequest{
		Spec:    createReq,
		RoleIds: []int64{}, // 如果你有角色 ID，也可以填这里
	}

	// 3. 传给 impl.CreateUser
	r, err := impl.CreateUser(ctx, updateReq)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(r)
}

// func TestCreateSubUser(t *testing.T) {
// 	req := user.NewCreateUserRequest()
// 	req.Domain = domain.DEFAULT_DOMAIN
// 	req.Username = "user"
// 	req.Password = "123456"
// 	req.Type = user.TYPE_SUB
// 	r, err := impl.CreateUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r.ToJson())
// }

// func TestQueryUser(t *testing.T) {
// 	req := user.NewQueryUserRequest()
// 	// req.UserIds = []int64{31, 34}
// 	r, err := impl.QueryUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r.ToJson())
// }

// func TestQueryKeywordsUser(t *testing.T) {
// 	req := user.NewQueryUserRequest()
// 	req.Keywords = "tetttt"
// 	r, err := impl.QueryUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r.ToJson())
// }

// func TestDescribeUser(t *testing.T) {
// 	req := user.NewDescriptUserRequestById("4")
// 	r, err := impl.DescribeUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r)
// }

// func TestDescribeUserByFeishuUserId(t *testing.T) {
// 	req := user.NewDescriptUserRequestByFeishuUserId(os.Getenv("FEISHU_USER_ID"))
// 	r, err := impl.DescribeUser(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r.ToJson())
// }

func TestDescribeUserByUsername(t *testing.T) {
	req := user.NewDescriptUserRequestByName("root")
	r, err := impl.DescribeUser(ctx, req)
	fmt.Println(r, "----r--->")
	if err != nil {
		t.Fatal(err)
	}
	// t.Log(r.User)
}

// func TestDeleteUser(t *testing.T) {
// 	req := user.DeleteUserRequest{
// 		UserIds: []int64{3},
// 	}

// 	res, err := impl.DeleteUser(ctx, &req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(res)
// }

// func TestGetUserRoles(t *testing.T) {
// 	req := user.NewGetUserRoleRequest("2")
// 	r, err := impl.GetUserRoles(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(r.ToJson())
// }

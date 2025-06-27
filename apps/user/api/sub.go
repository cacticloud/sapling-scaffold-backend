package api

import (
	"strconv"
	"time"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/cactikit/http/label"
	"github.com/cacticloud/cactikit/http/response"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	restfulspec "github.com/emicklei/go-restful-openapi/v2"
	"github.com/emicklei/go-restful/v3"
)

type primary struct {
	service user.Service
	log     logger.Logger
}

func (h *primary) Config() error {
	h.log = zap.L().Named(user.AppName)
	h.service = app.GetInternalApp(user.AppName).(user.Service)
	return nil
}

func (h *primary) Name() string {
	return "user/sub"
}

func (h *primary) Version() string {
	return "v1"
}

func (h *primary) Registry(ws *restful.WebService) {
	tags := []string{"子账号管理"}

	ws.Route(ws.POST("/").To(h.CreateUser).
		Metadata(label.Auth, true).
		Metadata(label.Resource, h.Name()).
		Metadata(label.Action, label.Create.Value()).
		Metadata(label.Permission, true).
		Metadata(label.Allow, user.TYPE_PRIMARY).
		Doc("创建子账号").
		Metadata(label.Perms, "sys:user:create").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Reads(user.UpdateUserRequest{}).
		Returns(200, "创建成功", &user.User{}))

	ws.Route(ws.GET("/").To(h.QueryUser).
		Metadata(label.Auth, true).
		// Metadata(label.Allow, user.TYPE_PRIMARY).
		Metadata(label.Resource, h.Name()).
		Metadata(label.Action, label.List.Value()).
		Metadata(label.Permission, true).
		Doc("查询子账号列表").
		Metadata(label.Perms, "sys:user:list").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Returns(200, "OK", user.UserSet{}))

	ws.Route(ws.GET("/{id}").To(h.DescribeUser).
		Doc("查询子账号详情").
		Metadata(label.Auth, true).
		Metadata(label.Resource, h.Name()).
		Metadata(label.Action, label.Get.Value()).
		Metadata(label.Permission, true).
		Param(ws.PathParameter("id", "identifier of the user").DataType("string")).
		Metadata(label.Perms, "sys:user:get").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Writes(user.User{}).
		Returns(200, "OK", user.User{}))

	ws.Route(ws.PUT("/{id}").To(h.PutUser).
		Doc("修改子账号").
		Metadata(label.Resource, h.Name()).
		Metadata(label.Auth, true).
		// Metadata(label.Allow, user.TYPE_PRIMARY).
		Metadata(label.Action, label.Update.Value()).
		Metadata(label.Permission, true).
		Metadata(label.Perms, "sys:user:update").
		Param(ws.PathParameter("id", "identifier of the user").DataType("string")).
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Reads(user.CreateUserRequest{}))

	ws.Route(ws.DELETE("/{id}").To(h.DeleteUser).
		Doc("删除子账号").
		Metadata(label.Resource, h.Name()).
		Metadata(label.Auth, true).
		// Metadata(label.Allow, user.TYPE_PRIMARY).
		Metadata(label.Action, label.Delete.Value()).
		Metadata(label.Permission, true).
		Metadata(label.Perms, "sys:user:delete").
		Param(ws.PathParameter("id", "identifier of the user").DataType("string")).
		Metadata(restfulspec.KeyOpenAPITags, tags))

	ws.Route(ws.POST("/{id}/password").To(h.ResetPassword).
		Doc("重置子账号密码").
		// Metadata(label.Resource, h.Name()).
		// Metadata(label.Auth, true).
		// Metadata(label.Allow, user.TYPE_PRIMARY).
		// Metadata(label.Action, label.Update.Value()).
		// Metadata(label.Permission, true).
		Param(ws.PathParameter("id", "identifier of the user").DataType("string")).
		Metadata(restfulspec.KeyOpenAPITags, tags))
}

func (h *primary) CreateUser(r *restful.Request, w *restful.Response) {

	req := user.NewCreateUserRoleRequest()

	if err := r.ReadEntity(req); err != nil {
		response.Failed(w, err)
		return
	}

	// tk := token.GetTokenFromRequest(r)
	// if tk == nil {
	// 	response.Failed(w, exception.NewUnauthorized("missing token"))
	// 	return
	// }

	// req.Spec.Domain = tk.Domain
	// req.Spec.CreateBy = tk.Username
	req.Spec.CreateAt = time.Now().Unix()
	set, err := h.service.CreateUser(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, set)
}

func (h *primary) PutUser(r *restful.Request, w *restful.Response) {
	req := user.NewPutUserRequest()
	if err := r.ReadEntity(req); err != nil {
		response.Failed(w, err)
		return
	}
	tk := token.GetTokenFromRequest(r)
	// putId, _ := utils.StringToInt64(r.PathParameter("id"))
	idStr := r.PathParameter("id")
	putId, err := strconv.ParseInt(idStr, 10, 64)
	if err != nil {
		response.Failed(w, exception.NewBadRequest("无效的 user id: %s", idStr))
		return
	}

	req.Spec.Id = putId
	req.Spec.UpdateBy = tk.Username
	req.Spec.Domain = tk.Domain
	set, err := h.service.UpdateUser(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, set)
}

func (h *primary) ResetPassword(r *restful.Request, w *restful.Response) {
	req := user.NewResetPasswordRequest()
	if err := r.ReadEntity(req); err != nil {
		response.Failed(w, err)
		return
	}
	req.UserId = r.PathParameter("id")

	set, err := h.service.ResetPassword(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, set)
}

func (h *primary) DeleteUser(r *restful.Request, w *restful.Response) {
	req := user.NewDeleteUserRequest()
	userID, _ := strconv.ParseInt(r.PathParameter("id"), 10, 64)

	req.UserIds = append(req.UserIds, userID)

	set, err := h.service.DeleteUser(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, set)
}

func (h *primary) QueryUser(r *restful.Request, w *restful.Response) {
	req := user.NewQueryUserRequestFromHTTP(r.Request)
	ins, err := h.service.QueryUser(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}

	response.Success(w, ins)
}
func (h *primary) DescribeUser(r *restful.Request, w *restful.Response) {
	const fn = "primary.DescribeUser"

	// 1. 解析 id
	idStr := r.PathParameter("id")
	id, err := strconv.ParseInt(idStr, 10, 64)
	if err != nil {
		response.Failed(w, exception.NewBadRequest("无效的 user id: %s", idStr))
		return
	}

	// 2. 构造请求，直接用 int64
	req := user.NewDescriptUserRequestById(strconv.FormatInt(id, 10))

	// 3. 调用 service
	resp, err := h.service.DescribeUser(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, resp)
}

func init() {
	app.RegistryRESTfulApp(&primary{})
}

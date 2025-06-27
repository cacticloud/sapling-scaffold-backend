package api

import (
	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/http/label"
	"github.com/cacticloud/cactikit/http/response"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	restfulspec "github.com/emicklei/go-restful-openapi/v2"
	"github.com/emicklei/go-restful/v3"
)

type sub struct {
	service user.Service
	log     logger.Logger
}

func (h *sub) Config() error {
	h.log = zap.L().Named(user.AppName)
	h.service = app.GetInternalApp(user.AppName).(user.Service)
	return nil
}

func (h *sub) Name() string {
	return "account"
}

func (h *sub) Version() string {
	return "v1"
}

func (h *sub) Registry(ws *restful.WebService) {
	tags := []string{"账号管理"}

	ws.Route(ws.POST("/password").To(h.UpdatePassword).
		Metadata(label.Auth, true).
		Metadata(label.Allow, user.TYPE_SUB).
		Doc("子账号修改自己密码").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Reads(user.UpdatePasswordRequest{}).
		Returns(0, "OK", &user.User{}))
}

func (h *sub) UpdatePassword(r *restful.Request, w *restful.Response) {
	req := user.NewUpdatePasswordRequest()
	if err := r.ReadEntity(req); err != nil {
		response.Failed(w, err)
		return
	}

	req.UserId = r.PathParameter("id")
	set, err := h.service.UpdatePassword(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, set)
}

func init() {
	app.RegistryRESTfulApp(&sub{})
}

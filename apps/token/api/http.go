package api

import (
	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/cactikit/http/label"
	"github.com/cacticloud/cactikit/logger"
	"github.com/cacticloud/cactikit/logger/zap"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	restfulspec "github.com/emicklei/go-restful-openapi/v2"
	"github.com/emicklei/go-restful/v3"
)

var (
	h = &handler{}
)

type handler struct {
	service token.Service
	log     logger.Logger
}

func (h *handler) Config() error {
	h.log = zap.L().Named(token.AppName)
	h.service = app.GetInternalApp(token.AppName).(token.Service)
	return nil
}

func (h *handler) Name() string {
	return token.AppName
}

func (h *handler) Version() string {
	return "v1"
}

func (h *handler) Registry(ws *restful.WebService) {
	tags := []string{"登录"}

	ws.Route(ws.POST("/").To(h.IssueToken).
		Doc("颁发令牌").
		Metadata(label.Resource, h.Name()).
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Reads(token.IssueTokenRequest{}).
		Writes(token.Token{}).
		Returns(200, "OK", token.Token{}))

	ws.Route(ws.DELETE("/").To(h.RevolkToken).
		Doc("撤销令牌").
		Metadata(label.Resource, h.Name()).
		Metadata(label.Auth, true).
		Metadata(label.Allow, user.TYPE_PRIMARY).
		Metadata(label.Action, label.Delete.Value()).
		Metadata(label.Permission, true).
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Writes(token.Token{}).
		Returns(200, "OK", token.Token{}).
		Returns(404, "Not Found", nil))

	ws.Route(ws.GET("/").To(h.ValidateToken).
		Doc("验证令牌").
		Metadata(restfulspec.KeyOpenAPITags, tags).
		Reads(token.ValidateTokenRequest{}).
		Writes(token.Token{}).
		Returns(200, "OK", token.Token{}))
}

func init() {
	app.RegistryRESTfulApp(h)
}

package api

import (
	"github.com/cacticloud/cactikit/http/restful/response"
	"github.com/cacticloud/sapling-scaffold-backend/apps/health"
	"github.com/emicklei/go-restful/v3"
)

func (h *handler) Check(r *restful.Request, w *restful.Response) {
	req := health.NewHealthCheckRequest()
	resp, err := h.service.Check(
		r.Request.Context(),
		req,
	)
	if err != nil {
		response.Failed(w, err)
		return
	}

	response.Success(w, NewHealth(resp))
}

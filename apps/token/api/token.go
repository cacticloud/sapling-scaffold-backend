package api

import (
	"strings"

	"github.com/cacticloud/cactikit/http/response"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/emicklei/go-restful/v3"
)

func (h *handler) IssueToken(r *restful.Request, w *restful.Response) {
	req := token.NewIssueTokenRequest()

	if err := r.ReadEntity(req); err != nil {
		response.Failed(w, err)
		return
	}

	tk, err := h.service.IssueToken(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}

	tk.SetCookie(w)
	response.Success(w, tk)
}

func (u *handler) RevolkToken(r *restful.Request, w *restful.Response) {
	qs := r.Request.URL.Query()
	req := token.NewRevolkTokenRequest("", "")
	req.AccessToken = token.GetAccessTokenFromHTTP(r.Request)
	req.RefreshToken = qs.Get("refresh_token")

	ins, err := h.service.RevolkToken(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}

	response.Success(w, ins)
}

func (u *handler) ValidateToken(r *restful.Request, w *restful.Response) {
	tk := r.Request.Header.Get(token.VALIDATE_TOKEN_HEADER_KEY)
	if tk == "" {
		// 再读 Authorization: Bearer ...
		auth := r.Request.Header.Get(token.ACCESS_TOKEN_HEADER_KEY) // "Authorization"
		if len(auth) > 7 && strings.ToLower(auth[0:6]) == "bearer" {
			tk = strings.TrimSpace(auth[6:])
		} else {
			tk = auth
		}
	}

	req := token.NewValidateTokenRequest(tk)
	resp, err := h.service.ValidateToken(r.Request.Context(), req)
	if err != nil {
		response.Failed(w, err)
		return
	}
	response.Success(w, resp)
}

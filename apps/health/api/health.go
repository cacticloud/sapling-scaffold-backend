// ─────────────────────────────────────────────────────────────────────────────
// File: apps/health/api/health.go
// ─────────────────────────────────────────────────────────────────────────────
package api

import (
	"time"

	"github.com/cacticloud/cactikit/http/restful/response"
	"github.com/cacticloud/sapling-scaffold-backend/apps/health"
	"github.com/emicklei/go-restful/v3"
)

// Check 是健康检查入口，调用底层 gRPC Health.Check 并返回丰富的 JSON
func (h *handler) Check(r *restful.Request, w *restful.Response) {
	const fn = "Health.Handler.Check"
	const lp = fn + " ---> "

	start := time.Now()
	h.log.Debugf("%s收到健康检查请求", lp)

	// 构造并调用 gRPC 请求
	grpcReq := health.NewHealthCheckRequest()
	grpcResp, err := h.service.Check(r.Request.Context(), grpcReq)
	if err != nil {
		h.log.Errorf("%s调用 HealthService.Check 失败: %v", lp, err)
		response.Failed(w, err)
		return
	}

	// 只输出一条 Info，包含状态与耗时
	h.log.Infof("%sHealth Check 完成 | 状态=%s | 耗时=%v", lp,
		grpcResp.Status.String(), time.Since(start).Truncate(time.Millisecond))

	// 返回更丰富的健康信息
	response.Success(w, NewHealth(grpcResp))
}

// ─────────────────────────────────────────────────────────────────────────────
// File: apps/health/api/health.go
// ─────────────────────────────────────────────────────────────────────────────
package api

import (
	"fmt"
	"os"
	"runtime"
	"time"

	"github.com/cacticloud/sapling-scaffold-backend/conf"
	"github.com/cacticloud/sapling-scaffold-backend/version"
	healthgrpc "google.golang.org/grpc/health/grpc_health_v1"
)

var startTime = time.Now()

// Health 是 RESTful 返回体，包含：服务名、版本、状态、时间戳、主机名、运行时长、Go 运行时指标
type Health struct {
	Service    string `json:"service"`    // 服务名
	Version    string `json:"version"`    // 服务版本
	Status     string `json:"status"`     // 健康状态
	Timestamp  string `json:"timestamp"`  // 当前时间戳
	Hostname   string `json:"hostname"`   // 主机名
	Uptime     string `json:"uptime"`     // 运行时长
	Goroutines int    `json:"goroutines"` // 当前 goroutine 数
	HeapAlloc  string `json:"heap_alloc"` // 分配的堆内存（可读格式）
	HeapSys    string `json:"heap_sys"`   // 系统分配的堆内存（可读格式）
}

// NewHealth 将 gRPC HealthCheckResponse 转为 RESTful Health 结构
func NewHealth(hc *healthgrpc.HealthCheckResponse) *Health {
	hostname, _ := os.Hostname()

	// 收集 Go 运行时内存指标
	var mem runtime.MemStats
	runtime.ReadMemStats(&mem)

	return &Health{
		Service:    conf.C().App.Name,
		Version:    version.FullVersion(),
		Status:     hc.Status.String(),
		Timestamp:  time.Now().Format(time.RFC3339),
		Hostname:   hostname,
		Uptime:     time.Since(startTime).Truncate(time.Second).String(),
		Goroutines: runtime.NumGoroutine(),
		HeapAlloc:  formatBytes(mem.HeapAlloc),
		HeapSys:    formatBytes(mem.HeapSys),
	}
}

// formatBytes 将字节数转换为带单位的可读字符串，如 "2.34 MB"
func formatBytes(b uint64) string {
	const (
		KB = 1 << (10 * (iota + 1))
		MB
		GB
	)
	switch {
	case b >= GB:
		return fmt.Sprintf("%.2f GB", float64(b)/float64(GB))
	case b >= MB:
		return fmt.Sprintf("%.2f MB", float64(b)/float64(MB))
	case b >= KB:
		return fmt.Sprintf("%.2f KB", float64(b)/float64(KB))
	default:
		return fmt.Sprintf("%d B", b)
	}
}

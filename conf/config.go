// conf/config.go
package conf

import (
	"fmt"

	"github.com/cacticloud/cactikit/cache/memory"
	"github.com/cacticloud/cactikit/cache/redis"
	"xorm.io/xorm"
)

// Config 整个应用的配置结构体
type Config struct {
	App   AppConfig   `toml:"app"`
	Log   LogConfig   `toml:"log"`
	MySQL MySQLConfig `toml:"mysql"`
	Cache CacheConfig `toml:"cache"`
}

// AppConfig 应用服务相关配置
type AppConfig struct {
	Name       string     `toml:"name" env:"APP_NAME"`
	EncryptKey string     `toml:"encrypt_key" env:"APP_ENCRYPT_KEY"`
	HTTP       HTTPConfig `toml:"http"`
	GRPC       GRPCConfig `toml:"grpc"`
}

// Addr 返回 HTTP 服务监听地址
func (h HTTPConfig) Addr() string {
	return fmt.Sprintf("%s:%s", h.Host, h.Port)
}

// HTTPConfig HTTP 服务监听配置
type HTTPConfig struct {
	Host      string `toml:"host" env:"HTTP_HOST"`
	Port      string `toml:"port" env:"HTTP_PORT"`
	EnableSSL bool   `toml:"enable_ssl" env:"HTTP_ENABLE_SSL"`
	CertFile  string `toml:"cert_file" env:"HTTP_CERT_FILE"`
	KeyFile   string `toml:"key_file" env:"HTTP_KEY_FILE"`
}

// GRPCConfig gRPC 服务监听配置
type GRPCConfig struct {
	Host      string `toml:"host" env:"GRPC_HOST"`
	Port      string `toml:"port" env:"GRPC_PORT"`
	EnableSSL bool   `toml:"enable_ssl" env:"GRPC_ENABLE_SSL"`
	CertFile  string `toml:"cert_file" env:"GRPC_CERT_FILE"`
	KeyFile   string `toml:"key_file" env:"GRPC_KEY_FILE"`
}

// Addr 返回 gRPC 服务监听地址
func (g GRPCConfig) Addr() string {
	return fmt.Sprintf("%s:%s", g.Host, g.Port)
}

// LogConfig 日志系统配置
type LogConfig struct {
	Level         string `toml:"level" env:"LOG_LEVEL"`
	PathDir       string `toml:"path_dir" env:"LOG_PATH_DIR"`
	Format        string `toml:"format" env:"LOG_FORMAT"`
	To            string `toml:"to" env:"LOG_TO"`
	ZapLevel      string `toml:"zap_level" env:"LOG_ZAP_LEVEL"`
	ShowLine      bool   `toml:"show_line" env:"LOG_SHOW_LINE"`
	OutType       string `toml:"out_type" env:"LOG_OUT_TYPE"`
	ConsoleFormat string `toml:"console_format" env:"LOG_CONSOLE_FORMAT"`
	FileFormat    string `toml:"file_format" env:"LOG_FILE_FORMAT"`
	Director      string `toml:"director" env:"LOG_DIRECTOR"`
	MaxSize       int    `toml:"max_size" env:"LOG_MAX_SIZE"`
	MaxBackups    int    `toml:"max_backups" env:"LOG_MAX_BACKUPS"`
	MaxAge        int    `toml:"max_age" env:"LOG_MAX_AGE"`
	Compress      bool   `toml:"compress" env:"LOG_COMPRESS"`
}

// MySQLConfig 数据库连接及 schema 导入设置
type MySQLConfig struct {
	Host      string `toml:"host" env:"MYSQL_HOST"`
	Port      string `toml:"port" env:"MYSQL_PORT"`
	Username  string `toml:"username" env:"MYSQL_USERNAME"`
	Password  string `toml:"password" env:"MYSQL_PASSWORD"`
	Database  string `toml:"database" env:"MYSQL_DATABASE"`
	Config    string `toml:"config" env:"MYSQL_CONFIG"` // DSN 额外参数
	MaxOpen   int    `toml:"max_open_conn" env:"MYSQL_MAX_OPEN_CONN"`
	MaxIdle   int    `toml:"max_idle_conn" env:"MYSQL_MAX_IDLE_CONN"`
	ShowSQL   bool   `toml:"show_sql" env:"MYSQL_SHOW_SQL"`
	SchemaDir string `toml:"schema_dir" env:"MYSQL_SCHEMA_DIR"` // schema SQL 文件目录
}

// GetDB 兼容旧调用，返回全局 *xorm.Engine
func (m MySQLConfig) GetDB() *xorm.Engine {
	return DB()
}

// CacheConfig 缓存配置，可选内存或 Redis
type CacheConfig struct {
	Type   string         `toml:"type" env:"CACHE_TYPE"`
	Memory *memory.Config `toml:"memory"`
	Redis  *redis.Config  `toml:"redis"`
}

func defaultApp() AppConfig {
	return AppConfig{
		Name:       "sapling_scaffold_backend",
		EncryptKey: "default_app_encrypt_key",
		HTTP: HTTPConfig{
			Host: "127.0.0.1", Port: "8010",
		},
		GRPC: GRPCConfig{
			Host: "127.0.0.1", Port: "18010",
		},
	}
}

func defaultLog() LogConfig {
	return LogConfig{
		Level:      "debug",
		PathDir:    "logs",
		Format:     "text",
		To:         "stdout",
		ZapLevel:   "debug",
		ShowLine:   true,
		Director:   "logs",
		MaxSize:    100,
		MaxBackups: 7,
		MaxAge:     7,
	}
}

func defaultMySQL() MySQLConfig {
	return MySQLConfig{
		Host:      "localhost",
		Port:      "3306",
		Username:  "root",
		Password:  "",
		Database:  "cacticloud",
		Config:    "charset=utf8mb4&parseTime=True&loc=Local",
		MaxOpen:   200,
		MaxIdle:   100,
		ShowSQL:   false,
		SchemaDir: "docs/schema",
	}
}

func defaultCache() CacheConfig {
	return CacheConfig{
		Type:   "memory",
		Memory: memory.NewDefaultConfig(),
		Redis:  redis.NewDefaultConfig(),
	}
}

func defaultConfig() Config {
	return Config{
		App:   defaultApp(),
		Log:   defaultLog(),
		MySQL: defaultMySQL(),
		Cache: defaultCache(),
	}
}

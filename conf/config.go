package conf

import (
	"database/sql"
	"fmt"
	"os"
	"strings"
	"sync"

	"github.com/cacticloud/cactikit/cache/memory"
	"github.com/cacticloud/cactikit/cache/redis"
	_ "github.com/go-sql-driver/mysql"
	"xorm.io/xorm"
	xorm_log "xorm.io/xorm/log"
)

var (
	db           *xorm.Engine
	wirteSqlTask sync.WaitGroup
	mysqlconf    *mysql
)

func newConfig() *Config {
	return &Config{
		App:   newDefaultAPP(),
		Log:   newDefaultLog(),
		MySQL: newDefaultMySQL(),
		Cache: newDefaultCache(),
	}
}

// Config 应用配置
type Config struct {
	App   *app    `toml:"app"`
	Log   *log    `toml:"log"`
	MySQL *mysql  `toml:"mysql"`
	Cache *_cache `toml:"cache"`
}

type app struct {
	Name       string `toml:"name" env:"APP_NAME"`
	EncryptKey string `toml:"encrypt_key" env:"APP_ENCRYPT_KEY"`
	HTTP       *http  `toml:"http"`
	GRPC       *grpc  `toml:"grpc"`
}

func newDefaultAPP() *app {
	return &app{
		Name:       "mcenter",
		EncryptKey: "default app encrypt key",
		HTTP:       newDefaultHTTP(),
		GRPC:       newDefaultGRPC(),
	}
}

type http struct {
	Host      string `toml:"host" env:"HTTP_HOST"`
	Port      string `toml:"port" env:"HTTP_PORT"`
	EnableSSL bool   `toml:"enable_ssl" env:"HTTP_ENABLE_SSL"`
	CertFile  string `toml:"cert_file" env:"HTTP_CERT_FILE"`
	KeyFile   string `toml:"key_file" env:"HTTP_KEY_FILE"`
}

func (a *http) Addr() string {
	return a.Host + ":" + a.Port
}

func newDefaultHTTP() *http {
	return &http{
		Host: "127.0.0.1",
		Port: "8010",
	}
}

type grpc struct {
	Host      string `toml:"host" env:"GRPC_HOST"`
	Port      string `toml:"port" env:"GRPC_PORT"`
	EnableSSL bool   `toml:"enable_ssl" env:"GRPC_ENABLE_SSL"`
	CertFile  string `toml:"cert_file" env:"GRPC_CERT_FILE"`
	KeyFile   string `toml:"key_file" env:"GRPC_KEY_FILE"`
}

func (a *grpc) Addr() string {
	return a.Host + ":" + a.Port
}

func newDefaultGRPC() *grpc {
	return &grpc{
		Host: "127.0.0.1",
		Port: "18010",
	}
}

type log struct {
	Level   string    `toml:"level" env:"LOG_LEVEL"`
	PathDir string    `toml:"path_dir" env:"LOG_PATH_DIR"`
	Format  LogFormat `toml:"format" env:"LOG_FORMAT"`
	To      LogTo     `toml:"to" env:"LOG_TO"`

	Zap_level      string `toml:"zap_level" env:"LOG_ZAP_LEVEL"`
	ShowLine       bool   `toml:"show_line" env:"LOG_SHOW_LINE"`
	OutType        string `toml:"out_type" env:"LOG_OUT_TYPE"`
	Console_format string `toml:"console_format" env:"LOG_CONSOLE_FORMAT"`
	File_format    string `toml:"file_format" env:"LOG_FILE_FORMAT"`
	Director       string `toml:"director" env:"LOG_DIRECTOR"`
	MaxSize        int    `toml:"max_size" env:"LOG_MAX_SIZE"`
	MaxBackups     int    `toml:"max_backups" env:"LOG_MAX_BACKUPS"`
	MaxAge         int    `toml:"max_age" env:"LOG_MAXAGE"`
	Compress       bool   `toml:"compress" env:"LOG_COMPRESS"`
}

func newDefaultLog() *log {
	return &log{
		Level:   "debug",
		PathDir: "logs",
		Format:  "text",
		To:      "stdout",
	}
}

type mysql struct {
	Host        string `toml:"host" env:"MYSQL_HOST"`
	Port        string `toml:"port" env:"MYSQL_PORT"`
	UserName    string `toml:"username" env:"MYSQL_USERNAME"`
	Password    string `toml:"password" env:"MYSQL_PASSWORD"`
	Database    string `toml:"database" env:"MYSQL_DATABASE"`
	Config      string `toml:"config" env:"MYSQL_CONFIG"`
	MaxOpenConn int    `toml:"max_open_conn" env:"MYSQL_MAX_OPEN_CONN"`
	MaxIdleConn int    `toml:"max_idle_conn" env:"MYSQL_MAX_IDLE_CONN"`

	Level      string `toml:"level" env:"MYSQL_LEVEL"`
	OutType    string `toml:"out_type" env:"MYSQL_OUT_TYPE"`
	ShowSQL    bool   `toml:"out_type" env:"MYSQL_SHOW_SQL"`
	Director   string `toml:"out_type" env:"MYSQL_DIRECTOR"`
	MaxSize    int    `toml:"out_type" env:"MYSQL_MAX_SIZE"`
	MaxBackups int    `toml:"max_backups" env:"MYSQL_MAX_BACKUPS"`
	MaxAge     int    `toml:"max_age" env:"MYSQL_MAX_AGE"`
	Compress   bool   `toml:"compress" env:"MYSQL_Compress"`
}

func newDefaultMySQL() *mysql {
	return &mysql{
		Database:    "cacticloud",
		UserName:    "root",
		Password:    "",
		Host:        "localhost",
		Port:        "3306",
		MaxOpenConn: 200,
		MaxIdleConn: 100,
	}
}

func (m *mysql) newXorm() (*xorm.Engine, error) {
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?%v", m.UserName, m.Password, m.Host, m.Port, m.Database, m.Config)
	db, err := xorm.NewEngine("mysql", dsn)

	// if m.OutType == "file" {
	// 	db.SetLogger(xorm_log.NewSimpleLogger(&lumberjack.Logger{
	// 		Filename:   "./" + m.Director + "/db.log",
	// 		MaxSize:    m.MaxSize,
	// 		MaxBackups: m.MaxBackups,
	// 		MaxAge:     m.MaxAge,
	// 		Compress:   m.Compress,
	// 	}))
	// } else {
	// 	db.SetLogger(xorm_log.NewSimpleLogger(os.Stdout))
	// }

	db.ShowSQL(m.ShowSQL)
	db.SetLogger(xorm_log.NewSimpleLogger(os.Stdout))
	db.SetLogLevel(xorm_log.LOG_DEBUG)
	db.SetMaxIdleConns(m.MaxIdleConn)
	db.SetMaxOpenConns(m.MaxOpenConn)
	return db, err
}

func (m *mysql) GetDB() *xorm.Engine {
	db, err := m.newXorm()
	if err != nil {
		panic(err.Error())
	}

	if err = db.Ping(); err != nil {
		if strings.Contains(err.Error(), "Unknown database") {
			return m.initDb()
		}
		panic(err.Error())
	}
	return db
}

func (m *mysql) initDb() *xorm.Engine {
	fmt.Println("未发现数据库,将自动创建...")
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/", m.UserName, m.Password, m.UserName, m.Port)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		panic(err.Error())
	}

	defer func(db *sql.DB) {
		if err := db.Close(); err != nil {
			fmt.Println(err.Error())
		}
	}(db)

	if err = db.Ping(); err != nil {
		panic(err.Error())
	}

	createSql := fmt.Sprintf("CREATE DATABASE `%s` DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;", m.Database)
	_, err = db.Exec(createSql)
	if err != nil {
		panic(err.Error())
	}
	fmt.Printf("数据库 %v 创建完毕...\n", m.Database)
	xormDb, err := m.newXorm()
	if err != nil {
		panic(err.Error())
	}
	m.writeSql(xormDb)
	return xormDb
}

func (m *mysql) writeSql(db *xorm.Engine) {
	db.ShowSQL(false)
	fmt.Println("开始导入数据表与数据...")
	path := "docs/schema/tables.sql"
	files := loadFiles(path)
	for _, file := range files {
		wirteSqlTask.Add(1)
		go importFile(db, path+file)
	}
	wirteSqlTask.Wait()
	fmt.Println("数据表与数据导入完成...")
	db.ShowSQL(m.ShowSQL)
}

// 加载文件
func loadFiles(path string) []string {
	file, err := os.OpenFile(path, os.O_RDONLY, os.ModeDir)
	if err != nil {
		panic(err.Error())
	}
	defer file.Close()
	fileInfo, _ := file.ReadDir(-1)
	files := []string{}
	for _, item := range fileInfo {
		files = append(files, item.Name())
	}
	return files
}

func importFile(db *xorm.Engine, path string) {
	_, err := db.ImportFile(path)
	if err != nil {
		fmt.Println(path + "导入失败 error:" + err.Error())
	}
	wirteSqlTask.Done()
}

// 日志配置
func (m *mysql) newLogger() xorm_log.LogLevel {
	var level xorm_log.LogLevel
	switch mysqlconf.Level {
	case "debug":
		level = xorm_log.LOG_DEBUG
	case "info":
		level = xorm_log.LOG_INFO
	case "warn":
		level = xorm_log.LOG_WARNING
	case "error":
		level = xorm_log.LOG_ERR
	default:
		level = xorm_log.LOG_INFO
	}
	return level
}

func newDefaultCache() *_cache {
	return &_cache{
		Type:   "memory",
		Memory: memory.NewDefaultConfig(),
		Redis:  redis.NewDefaultConfig(),
	}
}

type _cache struct {
	Type   string         `toml:"type" json:"type" yaml:"type" env:"MCENTER_CACHE_TYPE"`
	Memory *memory.Config `toml:"memory" json:"memory" yaml:"memory"`
	Redis  *redis.Config  `toml:"redis" json:"redis" yaml:"redis"`
}

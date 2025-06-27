// Package conf conf/db.go
package conf

import (
	"context"
	"database/sql"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"time"

	"github.com/cacticloud/cactikit/logger/zap"
	_ "github.com/go-sql-driver/mysql"
	"github.com/pkg/errors"
	"xorm.io/xorm"
	xormlog "xorm.io/xorm/log"
)

var (
	dbEngine *xorm.Engine
	dbOnce   sync.Once
)

// DB 返回全局唯一的 XORM 引擎，初始化失败时 panic
func DB() *xorm.Engine {
	dbOnce.Do(func() {
		if err := initEngine(); err != nil {
			panic(err)
		}
	})
	return dbEngine
}

// initEngine 创建引擎、Ping、自动建库、并发导入 schema
func initEngine() error {
	const fn = "conf.initEngine"
	const lp = fn + " ---> "
	log := zap.L().Named("DB")

	cfg := C().MySQL

	// 1）构造 DSN 并创建 XORM 引擎
	dsn := fmt.Sprintf(
		"%s:%s@tcp(%s:%s)/%s?%s",
		cfg.Username, cfg.Password,
		cfg.Host, cfg.Port,
		cfg.Database, cfg.Config,
	)
	log.Infof("%s 构造 XORM 引擎，DSN=%s", lp, dsn)
	engine, err := xorm.NewEngine("mysql", dsn)
	if err != nil {
		log.Errorf("%s 创建 XORM 引擎失败：%v", lp, err)
		return errors.Wrap(err, lp+"创建 XORM 引擎失败")
	}
	engine.SetMaxIdleConns(cfg.MaxIdle)
	engine.SetMaxOpenConns(cfg.MaxOpen)
	engine.ShowSQL(cfg.ShowSQL)
	engine.SetLogger(xormlog.NewSimpleLogger(os.Stdout))
	engine.SetLogLevel(xormlog.LOG_DEBUG)
	log.Infof("%s 配置连接池，MaxIdle=%d, MaxOpen=%d, ShowSQL=%t", lp,
		cfg.MaxIdle, cfg.MaxOpen, cfg.ShowSQL)

	// 2）Ping 测试
	log.Debugf("%s 开始 Ping 数据库", lp)
	if err := engine.Ping(); err != nil {
		if strings.Contains(err.Error(), "Unknown database") {
			log.Warnf("%s 数据库 %q 不存在，即将自动创建", lp, cfg.Database)
			if err := createDatabase(cfg); err != nil {
				log.Errorf("%s 自动创建数据库失败：%v", lp, err)
				return errors.Wrap(err, lp+"createDatabase 失败")
			}
			log.Infof("%s 数据库 %q 创建成功", lp, cfg.Database)
		} else {
			log.Errorf("%s Ping 数据库失败：%v", lp, err)
			return errors.Wrap(err, lp+"Ping 数据库失败")
		}
	} else {
		log.Infof("%s Ping 数据库成功", lp)
	}

	// 3）并发导入 schema（可选）
	if cfg.SchemaDir != "" {
		log.Infof("%s 开始导入 schema 目录：%s", lp, cfg.SchemaDir)
		if err := importSchema(engine, cfg.SchemaDir, lp); err != nil {
			log.Errorf("%s 导入 schema 失败：%v", lp, err)
			return errors.Wrap(err, lp+"importSchema 失败")
		}
		log.Infof("%s 导入 schema 完成", lp)
	}

	dbEngine = engine
	log.Infof("%s XORM 引擎初始化完成", lp)
	return nil
}

func createDatabase(cfg MySQLConfig) error {
	const fn = "conf.createDatabase"
	const lp = fn + " ---> "
	log := zap.L().Named("DB")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	dsnRoot := fmt.Sprintf(
		"%s:%s@tcp(%s:%s)/?%s",
		cfg.Username, cfg.Password,
		cfg.Host, cfg.Port,
		cfg.Config,
	)
	log.Debugf("%s 使用 root DSN 连接创建数据库：%s", lp, dsnRoot)
	sqlDB, err := sql.Open("mysql", dsnRoot)
	if err != nil {
		log.Errorf("%s sql.Open 失败：%v", lp, err)
		return errors.Wrap(err, lp+"sql.Open 失败")
	}
	defer sqlDB.Close()

	if err := sqlDB.PingContext(ctx); err != nil {
		log.Errorf("%s PingContext 失败：%v", lp, err)
		return errors.Wrap(err, lp+"PingContext 失败")
	}

	createSQL := fmt.Sprintf(
		"CREATE DATABASE `%s` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;",
		cfg.Database,
	)
	log.Debugf("%s 执行建库 SQL：%s", lp, createSQL)
	if _, err := sqlDB.ExecContext(ctx, createSQL); err != nil {
		log.Errorf("%s 执行建库 SQL 失败：%v", lp, err)
		return errors.Wrap(err, lp+"ExecContext 失败")
	}
	return nil
}

// importSchema 并发扫描并导入所有 .sql 文件
func importSchema(engine *xorm.Engine, dir string, lp string) error {
	// fn := "conf.importSchema"
	log := zap.L().Named("DB")
	start := time.Now()

	// 临时关闭 SQL 打印，加快导入
	engine.ShowSQL(false)
	defer engine.ShowSQL(C().MySQL.ShowSQL)

	var wg sync.WaitGroup
	errCh := make(chan error, 1)

	err := filepath.WalkDir(dir, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if d.IsDir() || !strings.HasSuffix(d.Name(), ".sql") {
			return nil
		}
		wg.Add(1)
		go func(p string) {
			defer wg.Done()
			log.Debugf("%s 开始导入文件：%s", lp, p)
			if _, impErr := engine.ImportFile(p); impErr != nil {
				errWrap := errors.Wrapf(impErr, "%s 文件导入失败", p)
				select {
				case errCh <- errWrap:
				default:
				}
			} else {
				log.Debugf("%s 完成导入文件：%s", lp, p)
			}
		}(path)
		return nil
	})
	if err != nil {
		return err
	}

	wg.Wait()
	select {
	case e := <-errCh:
		return e
	default:
	}

	log.Infof("%s 所有 schema 导入完成，耗时=%s", lp, time.Since(start))
	return nil
}

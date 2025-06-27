package zap

import (
	"fmt"
	"os"
	"time"

	"github.com/cacticloud/sapling-scaffold-backend/common/zap/lumberjack"
	"github.com/cacticloud/sapling-scaffold-backend/conf"
	"github.com/gookit/color"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var (
	lc conf.Config
)

func AddZap() *zap.Logger {
	options := []zap.Option{}
	if lc.Log.ShowLine {
		options = append(options, zap.AddCaller())
	}

	if level() == zap.DebugLevel || level() == zap.ErrorLevel {
		options = append(options, zap.AddStacktrace(level()))
	}
	return zap.New(core(), options...)
}

func core() zapcore.Core {
	var teeCore []zapcore.Core
	consoleCore := zapcore.NewCore(encoder(true), zapcore.Lock(os.Stdout), level())
	fileCore := zapcore.NewCore(encoder(false), writerSyncerConfig(), level())

	switch lc.Log.OutType {
	case "console":
		teeCore = append(teeCore, consoleCore)
	case "file":
		teeCore = append(teeCore, fileCore)
	default:
		teeCore = append(teeCore, consoleCore, fileCore)
	}
	return zapcore.NewTee(teeCore...)
}
func encoder(isConsole bool) zapcore.Encoder {
	var format string
	if isConsole {
		format = lc.Log.Console_format
	} else {
		format = lc.Log.File_format
	}
	if format == "json" {
		return zapcore.NewJSONEncoder(encoderConfig(isConsole))
	}
	return zapcore.NewConsoleEncoder(encoderConfig(isConsole))

}

func encoderConfig(isConsole bool) zapcore.EncoderConfig {
	var encoderTime zapcore.TimeEncoder
	var encodeLevel zapcore.LevelEncoder
	if isConsole {
		encoderTime = consoleEncoderTime
		encodeLevel = consoleEncodeLevel
	} else {
		encoderTime = fileEncoderTime
		encodeLevel = fileEncodeLevel
	}
	encoderConfig := zapcore.EncoderConfig{
		TimeKey:          "time",
		MessageKey:       "message",
		LevelKey:         "level",
		CallerKey:        "caller",
		StacktraceKey:    "stacktrace",
		EncodeTime:       encoderTime,
		EncodeLevel:      encodeLevel,
		EncodeCaller:     zapcore.ShortCallerEncoder, // FullCallerEncoder || ShortCallerEncoder
		EncodeDuration:   zapcore.SecondsDurationEncoder,
		ConsoleSeparator: " ",
	}
	return encoderConfig
}
func writerSyncerConfig() zapcore.WriteSyncer {

	lumberJackLogger := &lumberjack.Logger{
		Filename:         "./" + lc.Log.Director + "/runtime.log",
		MaxSize:          lc.Log.MaxSize,
		MaxBackups:       lc.Log.MaxBackups,
		MaxAge:           lc.Log.MaxAge,
		Compress:         lc.Log.Compress,
		BackupTimeFormat: "2006-01-02T15-04-05",
	}
	return zapcore.AddSync(lumberJackLogger)
}
func level() zapcore.Level {
	l := new(zapcore.Level)
	err := l.UnmarshalText([]byte(lc.Log.Level))
	if err != nil {
		return zap.InfoLevel
	}
	return *l
}
func consoleEncodeLevel(level zapcore.Level, enc zapcore.PrimitiveArrayEncoder) {
	if lc.Log.Console_format == "json" {
		enc.AppendString(level.CapitalString())
		return
	}
	enc.AppendString(colorEnc(string(fmt.Sprint(level)), "["+level.CapitalString()+"]"))
}
func consoleEncoderTime(time time.Time, enc zapcore.PrimitiveArrayEncoder) {
	if lc.Log.Console_format == "json" {
		enc.AppendString(time.Format("2006/01/02 15:04:05"))
		return
	}
	enc.AppendString("[" + "mcenter" + "]")
	enc.AppendString("[" + time.Format("2006/01/02 15:04:05") + "]")
}
func fileEncodeLevel(level zapcore.Level, enc zapcore.PrimitiveArrayEncoder) {
	if lc.Log.File_format == "json" {
		enc.AppendString(level.CapitalString())
		return
	}
	enc.AppendString("[" + level.CapitalString() + "]")
}
func fileEncoderTime(time time.Time, enc zapcore.PrimitiveArrayEncoder) {
	if lc.Log.File_format == "json" {
		enc.AppendString(time.Format("2006/01/02 15:04:05"))
		return
	}
	enc.AppendString("[" + "mcenter" + "]")
	enc.AppendString("[" + time.Format("2006/01/02 15:04:05") + "]")
}

// 给标签上个色
func colorEnc(level string, value string) string {
	switch level {
	case "debug":
		return color.Debug.Sprintf(value)
	case "info":
		return color.Info.Sprintf(value)
	case "warn":
		return color.Warn.Sprintf(value)
	case "error":
		return color.Error.Sprintf(value)
	default:
		return color.Light.Sprintf(value)
	}
}

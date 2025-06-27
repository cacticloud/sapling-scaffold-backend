package impl_test

import (
	"context"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/test/tools"
)

var (
	impl token.Service
	ctx  = context.Background()
)

func init() {
	tools.DevelopmentSetup()
	impl = app.GetInternalApp(token.AppName).(token.Service)
}

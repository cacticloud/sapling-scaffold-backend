package impl_test

import (
	"context"

	"github.com/cacticloud/cactikit/app"
	"github.com/cacticloud/sapling-scaffold-backend/apps/user"
	"github.com/cacticloud/sapling-scaffold-backend/test/tools"
)

var (
	impl user.Service
	ctx  = context.Background()
)

func init() {
	tools.DevelopmentSetup()
	impl = app.GetInternalApp(user.AppName).(user.Service)
}

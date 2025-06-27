package private_token_test

import (
	"context"
	"testing"

	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
	"github.com/cacticloud/sapling-scaffold-backend/apps/token/provider"
	"github.com/cacticloud/sapling-scaffold-backend/test/tools"
)

var (
	impl provider.TokenIssuer
	ctx  = context.Background()
)

func TestIssueToken(t *testing.T) {
	req := token.NewPrivateTokenIssueTokenRequest("TrXmcSBvVssEgdVPGW948oiR", "测试")
	tk, err := impl.IssueToken(ctx, req)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(tk.JsonFormat())
}

func init() {
	tools.DevelopmentSetup()
	impl = provider.GetTokenIssuer(token.GRANT_TYPE_PRIVATE_TOKEN)
}

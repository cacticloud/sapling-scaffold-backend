package impl_test

import (
	"testing"

	"github.com/cacticloud/sapling-scaffold-backend/apps/token"
)

func TestIssueToken(t *testing.T) {
	req := token.NewIssueTokenRequest()
	req.GrantType = token.GRANT_TYPE_PASSWORD
	req.Username = "root"
	req.Password = "123456"
	tk, err := impl.IssueToken(ctx, req)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(tk.ToJson())
}

// func TestRevolkToken(t *testing.T) {
// 	req := token.NewRevolkTokenRequest("NJQZFEKkiJ4RqRtsGcfnWZFu", "lLLOr6YaLiDnUqaOcmd0JQWWTs6vWSrm")
// 	tk, err := impl.RevolkToken(ctx, req)
// 	if err != nil {
// 		t.Fatal(err)
// 	}
// 	t.Log(tk.ToJson())
// }

func TestDescribeToken(t *testing.T) {
	req := token.NewDescribeTokenRequest("Jphq0MUPFEB3JdkSEDKiog2e")
	tk, err := impl.DescribeToken(ctx, req)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(tk.ToJson())
}

// func TestValidateToken(t *testing.T) {
//	req := token.NewValidateTokenRequest("NJQZFEKkiJ4RqRtsGcfnWZFu")
//	tk, err := impl.ValidateToken(ctx, req)
//	if err != nil {
//		t.Fatal(err)
//	}
//
//	t.Log(tk.ToJson())
// }

//
// func TestQueryToken(t *testing.T) {
//	req := token.NewQueryTokenRequest()
//	set, err := impl.QueryToken(ctx, req)
//	if err != nil {
//		t.Fatal(err)
//	}
//	t.Log(set.JsonFormat())
// }
//
// func TestChangeNamespace(t *testing.T) {
//	req := token.NewChangeNamespaceRequest()
//	req.Namespace = ""
//	req.Token = tools.AccessToken()
//	tk, err := impl.ChangeNamespace(ctx, req)
//	if err != nil {
//		t.Fatal(err)
//	}
//	t.Log(tk)
// }

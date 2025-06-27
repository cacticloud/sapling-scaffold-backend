package token

import (
	"fmt"
	"time"

	"github.com/cacticloud/cactikit/types/ftime"
	"github.com/emicklei/go-restful/v3"
)

func GetTokenFromRequest(r *restful.Request) *Token {
	tk := r.Attribute(TOKEN_ATTRIBUTE_NAME)
	if tk == nil {
		return nil
	}
	return tk.(*Token)
}

// 撤销Token请求
func NewRevolkTokenRequest(accessToken, refreshToken string) *RevolkTokenRequest {
	return &RevolkTokenRequest{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}
}

// 检测token是否过期
func (t *Token) CheckAccessIsExpired() bool {
	if t.AccessExpiredAt == 0 {
		return false
	}
	// fmt.Println(time.Unix(t.AccessExpiredAt/1000, (t.IssueAt%1000)*t.IssueAt), "----123123--------------->")
	// fmt.Println(uint32(time.Since(time.UnixMilli(t.IssueAt)).Hours()/24), "------------------>")
	now := ftime.Now()
	fmt.Println(now.Timestamp(), "-----12341234---------?")
	return time.Unix(t.AccessExpiredAt/1000, 0).Before(time.Now())
}

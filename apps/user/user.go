package user

import (
	"encoding/json"
	"net/http"
	"strings"
	"time"

	"github.com/cacticloud/cactikit/exception"
	"github.com/cacticloud/cactikit/http/request"
	"github.com/cacticloud/sapling-scaffold-backend/apps/domain"
	"github.com/cacticloud/sapling-scaffold-backend/common/format"
	"github.com/go-playground/validator/v10"
	"golang.org/x/crypto/bcrypt"
)

// use a single instance of Validate, it caches struct info
var (
	validate = validator.New()
)

// New 实例
func New(req *UpdateUserRequest) (*UpdateUserRequest, error) {
	if err := req.Validate(); err != nil {
		return nil, exception.NewBadRequest(err.Error())
	}
	plaintextPwd := req.Spec.Password
	pass, err := NewHashedPassword(plaintextPwd)
	if err != nil {
		return nil, exception.NewBadRequest(err.Error())
	}
	req.Spec.Password = pass

	u := &UpdateUserRequest{
		Spec: req.Spec,
	}

	return u, nil
}

func NewCreateUserRequest() *CreateUserRequest {
	return &CreateUserRequest{
		Feishu:  &Feishu{},
		Profile: &Profile{},
	}
}

func NewCreateUserRoleRequest() *UpdateUserRequest {
	return &UpdateUserRequest{
		Spec: NewCreateUserRequest(),
	}
}

func NewFeishu() *Feishu {
	return &Feishu{}
}

// NewHashedPassword 生产hash后的密码对象
func NewHashedPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 10)
	if err != nil {
		return "", err
	}
	hashpwd := string(bytes)
	return hashpwd, nil
}

// CheckPassword 判断password 是否正确
func (p *User) CheckPassword(password string) error {
	err := bcrypt.CompareHashAndPassword([]byte(p.Spec.Password), []byte(password))
	if err != nil {
		return exception.NewUnauthorized("user or password not connect")
	}

	return nil
}

// CheckPassword 判断password 是否正确
func (p *UpdateUserRequest) CheckPassword(password string) error {
	err := bcrypt.CompareHashAndPassword([]byte(p.Spec.Password), []byte(password))
	if err != nil {
		return exception.NewUnauthorized("user or password not connect")
	}

	return nil
}

func (req *CreateUserRequest) Validate() error {
	return validate.Struct(req)
}

func (req *UpdateUserRequest) Validate() error {
	return validate.Struct(req)
}

func (req *CreateUserRequest) GetFeishuUserId() int64 {
	if req.Feishu == nil {
		return 0
	}
	return req.Feishu.UserId
}

func NewQueryUserRequestFromHTTP(r *http.Request) *QueryUserRequest {
	query := NewQueryUserRequest()

	qs := r.URL.Query()
	query.Page = request.NewPageRequestFromHTTP(r)
	query.Keywords = qs.Get("keywords")
	query.SkipItems = qs.Get("skip_items") == "true"

	// uids := qs.Get("user_ids")
	// fmt.Println(uids, "======uids----->")
	// if uids != "" {
	// 	query.UserIds = strings.Split(uids, ",")
	// }
	return query
}

func NewQueryUserRequest() *QueryUserRequest {
	return &QueryUserRequest{
		Page:      request.NewPageRequest(20, 1),
		SkipItems: false,
	}
}

func NewDescriptUserRequestById(id string) *DescribeUserRequest {
	return &DescribeUserRequest{
		DescribeBy: DESCRIBE_BY_USER_ID,
		Id:         id,
	}
}

func NewDescriptUserRequestByFeishuUserId(id string) *DescribeUserRequest {
	return &DescribeUserRequest{
		DescribeBy: DESCRIBE_BY_FEISHU_USER_ID,
		Id:         id,
	}
}

func NewDescriptUserRequestByName(username string) *DescribeUserRequest {
	return &DescribeUserRequest{
		DescribeBy: DESCRIBE_BY_USER_NAME,
		Username:   username,
	}
}

func NewDescribeUserResponse() *DescribeUserResponse {
	return &DescribeUserResponse{}
}

func NewPutUserRequest() *UpdateUserRequest {
	return &UpdateUserRequest{
		Spec: NewCreateUserRequest(),
	}
}

func NewDeleteUserRequest() *DeleteUserRequest {
	return &DeleteUserRequest{
		UserIds: []int64{},
	}
}

func NewResetPasswordRequest() *ResetPasswordRequest {
	return &ResetPasswordRequest{}
}

func NewUpdatePasswordRequest() *UpdatePasswordRequest {
	return &UpdatePasswordRequest{}
}

func NewUserSet() *UserSet {
	return &UserSet{
		Items: []*User{},
	}
}

func (s *UserSet) ToJson() string {
	return format.Prettify(s)
}

func (s *UserSet) Add(item *User) {
	s.Items = append(s.Items, item)
}

func (s *UserSet) HasUser(userId int64) bool {
	for i := range s.Items {
		if s.Items[i].Spec.Id == userId {
			return true
		}
	}

	return false
}

func (s *UserSet) UserIds() (uids []int64) {
	for i := range s.Items {
		uids = append(uids, s.Items[i].Spec.Id)
	}

	return
}

// func NewDefaultRoleList() *RoleList {
// 	return &RoleList{}
// }

func NewDefaultUser() *User {
	return &User{
		Spec: &CreateUserRequest{
			Feishu:  &Feishu{},
			Profile: &Profile{},
		},
	}
}

// Desensitize 关键数据脱敏
func (u *User) Desensitize() {
	if u.Spec.Password != "" {
		u.Spec.Password = ""
	}
}

func (u *User) ToJson() string {
	return format.Prettify(u)
}

func (u *GetUserRoleResponse) ToJson() string {
	return format.Prettify(u)
}

func (u *User) MarshalJSON() ([]byte, error) {
	return json.Marshal(struct {
		*CreateUserRequest
	}{u.Spec})
}

func (i *DescribeUserResponse) Update(req *UpdateUserRequest) {
	i.User.Spec = req.Spec
	pass, _ := NewHashedPassword(req.Spec.Password)
	i.User.Spec.Password = pass
	i.User.Spec.UpdateAt = time.Now().Unix()
}

// SetupDefault 初始化一些空值, 兼容之前的数据
func (i *User) SetupDefault() {
	if i.Spec.Feishu == nil {
		i.Spec.Feishu = NewFeishu()
	}
}

func SpliteUserAndDomain(username string) (string, string) {
	kvs := strings.Split(username, "@")
	if len(kvs) > 1 {
		dom := strings.Join(kvs[1:], "")
		if dom == "" {
			dom = domain.DEFAULT_DOMAIN
		}
		return kvs[0], dom
	}

	return username, domain.DEFAULT_DOMAIN
}

func NewGetUserRoleRequest(id string) *GetUserRoleRequest {
	return &GetUserRoleRequest{
		DescribeBy: DESCRIBE_BY_USER_ID,
		Id:         id,
	}
}

func NewGetUserRoleResponse() *GetUserRoleResponse {
	return &GetUserRoleResponse{}
}

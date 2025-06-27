package user

import (
	"bytes"
	"fmt"
	"strings"
)

// ParsePROVIDERFromString Parse PROVIDER from string
func ParsePROVIDERFromString(str string) (PROVIDER, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := PROVIDER_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown PROVIDER: %v", str)
	}

	return PROVIDER(v), nil
}

// Equal type compare
func (t PROVIDER) Equal(target PROVIDER) bool {
	return t == target
}

// IsIn todo
func (t PROVIDER) IsIn(targets ...PROVIDER) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t PROVIDER) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *PROVIDER) UnmarshalJSON(b []byte) error {
	ins, err := ParsePROVIDERFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseTYPEFromString Parse TYPE from string
func ParseTYPEFromString(str string) (TYPE, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := TYPE_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown TYPE: %v", str)
	}

	return TYPE(v), nil
}

// Equal type compare
func (t TYPE) Equal(target TYPE) bool {
	return t == target
}

// IsIn todo
func (t TYPE) IsIn(targets ...TYPE) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t TYPE) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *TYPE) UnmarshalJSON(b []byte) error {
	ins, err := ParseTYPEFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseGenderFromString Parse Gender from string
func ParseGenderFromString(str string) (Gender, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := Gender_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown Gender: %v", str)
	}

	return Gender(v), nil
}

// Equal type compare
func (t Gender) Equal(target Gender) bool {
	return t == target
}

// IsIn todo
func (t Gender) IsIn(targets ...Gender) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t Gender) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *Gender) UnmarshalJSON(b []byte) error {
	ins, err := ParseGenderFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseStatusFromString Parse Status from string
func ParseStatusFromString(str string) (Status, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := Status_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown Status: %v", str)
	}

	return Status(v), nil
}

// Equal type compare
func (t Status) Equal(target Status) bool {
	return t == target
}

// IsIn todo
func (t Status) IsIn(targets ...Status) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t Status) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *Status) UnmarshalJSON(b []byte) error {
	ins, err := ParseStatusFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseDESCRIBE_BYFromString Parse DESCRIBE_BY from string
func ParseDESCRIBE_BYFromString(str string) (DESCRIBE_BY, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := DESCRIBE_BY_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown DESCRIBE_BY: %v", str)
	}

	return DESCRIBE_BY(v), nil
}

// Equal type compare
func (t DESCRIBE_BY) Equal(target DESCRIBE_BY) bool {
	return t == target
}

// IsIn todo
func (t DESCRIBE_BY) IsIn(targets ...DESCRIBE_BY) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t DESCRIBE_BY) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *DESCRIBE_BY) UnmarshalJSON(b []byte) error {
	ins, err := ParseDESCRIBE_BYFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

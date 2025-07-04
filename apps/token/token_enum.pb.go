package token

import (
	"bytes"
	"fmt"
	"strings"
)

// ParseGRANT_TYPEFromString Parse GRANT_TYPE from string
func ParseGRANT_TYPEFromString(str string) (GRANT_TYPE, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := GRANT_TYPE_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown GRANT_TYPE: %v", str)
	}

	return GRANT_TYPE(v), nil
}

// Equal type compare
func (t GRANT_TYPE) Equal(target GRANT_TYPE) bool {
	return t == target
}

// IsIn todo
func (t GRANT_TYPE) IsIn(targets ...GRANT_TYPE) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t GRANT_TYPE) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *GRANT_TYPE) UnmarshalJSON(b []byte) error {
	ins, err := ParseGRANT_TYPEFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseTOKEN_TYPEFromString Parse TOKEN_TYPE from string
func ParseTOKEN_TYPEFromString(str string) (TOKEN_TYPE, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := TOKEN_TYPE_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown TOKEN_TYPE: %v", str)
	}

	return TOKEN_TYPE(v), nil
}

// Equal type compare
func (t TOKEN_TYPE) Equal(target TOKEN_TYPE) bool {
	return t == target
}

// IsIn todo
func (t TOKEN_TYPE) IsIn(targets ...TOKEN_TYPE) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t TOKEN_TYPE) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *TOKEN_TYPE) UnmarshalJSON(b []byte) error {
	ins, err := ParseTOKEN_TYPEFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParseBLOCK_TYPEFromString Parse BLOCK_TYPE from string
func ParseBLOCK_TYPEFromString(str string) (BLOCK_TYPE, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := BLOCK_TYPE_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown BLOCK_TYPE: %v", str)
	}

	return BLOCK_TYPE(v), nil
}

// Equal type compare
func (t BLOCK_TYPE) Equal(target BLOCK_TYPE) bool {
	return t == target
}

// IsIn todo
func (t BLOCK_TYPE) IsIn(targets ...BLOCK_TYPE) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t BLOCK_TYPE) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *BLOCK_TYPE) UnmarshalJSON(b []byte) error {
	ins, err := ParseBLOCK_TYPEFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

// ParsePLATFORMFromString Parse PLATFORM from string
func ParsePLATFORMFromString(str string) (PLATFORM, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := PLATFORM_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown PLATFORM: %v", str)
	}

	return PLATFORM(v), nil
}

// Equal type compare
func (t PLATFORM) Equal(target PLATFORM) bool {
	return t == target
}

// IsIn todo
func (t PLATFORM) IsIn(targets ...PLATFORM) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t PLATFORM) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *PLATFORM) UnmarshalJSON(b []byte) error {
	ins, err := ParsePLATFORMFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

package token

import (
	"bytes"
	"fmt"
	"strings"
)

// ParseDESCRIBY_BYFromString Parse DESCRIBY_BY from string
func ParseDESCRIBY_BYFromString(str string) (DESCRIBY_BY, error) {
	key := strings.Trim(string(str), `"`)
	v, ok := DESCRIBY_BY_value[strings.ToUpper(key)]
	if !ok {
		return 0, fmt.Errorf("unknown DESCRIBY_BY: %v", str)
	}

	return DESCRIBY_BY(v), nil
}

// Equal type compare
func (t DESCRIBY_BY) Equal(target DESCRIBY_BY) bool {
	return t == target
}

// IsIn todo
func (t DESCRIBY_BY) IsIn(targets ...DESCRIBY_BY) bool {
	for _, target := range targets {
		if t.Equal(target) {
			return true
		}
	}

	return false
}

// MarshalJSON todo
func (t DESCRIBY_BY) MarshalJSON() ([]byte, error) {
	b := bytes.NewBufferString(`"`)
	b.WriteString(strings.ToUpper(t.String()))
	b.WriteString(`"`)
	return b.Bytes(), nil
}

// UnmarshalJSON todo
func (t *DESCRIBY_BY) UnmarshalJSON(b []byte) error {
	ins, err := ParseDESCRIBY_BYFromString(string(b))
	if err != nil {
		return err
	}
	*t = ins
	return nil
}

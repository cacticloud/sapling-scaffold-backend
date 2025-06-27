package utils

import "strconv"

type cumsum interface {
	int | int8 | int16 | int32 | int64 | uint | uint8 | uint16 | uint32 | uint64 | string
}

// 查询切片内是否包含某个值
func SliceIncludes[T cumsum](arr []T, formIndex T) bool {
	is := false
	for _, item := range arr {
		if item == formIndex {
			is = true
		}
	}
	return is
}

// StringSliceToIntSlice []string 转换为 []int
func StringSliceToIntSlice(strSlice []string) ([]int, error) {
	intSlice := make([]int, len(strSlice))
	for i, str := range strSlice {
		num, err := strconv.Atoi(str)
		if err != nil {
			return nil, err
		}
		intSlice[i] = num
	}
	return intSlice, nil
}

// Int64SliceToIntSlice []int64 转换为 []int
func Int64SliceToIntSlice(int64Slice []int64) ([]int, error) {
	intSlice := make([]int, len(int64Slice))
	for i, v := range int64Slice {
		intSlice[i] = int(v)
	}
	return intSlice, nil
}

func StringToInt64(id string) (int64, error) {
	num, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		return 0, err
	}
	return num, nil
}

func Int64ToString(num int64) string {
	return strconv.FormatInt(num, 10)
}

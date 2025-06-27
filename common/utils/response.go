package utils

func DeleteResponse(code int, data interface{}) map[string]interface{} {
	return map[string]interface{}{
		"code": code,
		"data": data,
	}
}

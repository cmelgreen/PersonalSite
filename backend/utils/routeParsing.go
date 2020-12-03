package utils

import (
	"PersonalSite/backend/models"

	"encoding/json"
)

// ParseRoutesToRedirect takes a byte string and returns list of routes to be redirected 
func ParseRoutesToRedirect(file []byte) []string {
	var routeFile models.RouteFile
	var routeStrings []string

	json.Unmarshal(file, &routeFile)

	for _, route := range routeFile.Routes {
		if route.Redirect == true {
			routeStrings = append(routeStrings, route.Path)
		}
	}

	return routeStrings
}
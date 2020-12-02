package main

import (
	"encoding/json"
)

func parseRoutes(file []byte) []string {
	var routeFile routeFile
	var routeStrings []string

	json.Unmarshal(file, &routeFile)

	for _, route := range routeFile.Routes {
		if route.Redirect == true {
			routeStrings = append(routeStrings, route.Path)
		}
	}

	return routeStrings
}
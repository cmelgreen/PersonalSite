package main

import "net/http"

// FSDummy is a placeholder for compile-time static generated filesystem
type FSDummy struct {
	http.FileSystem
}

// FS is a placeholder for compile-time static generated filesystem  
func FS(_ bool) http.FileSystem {
	return FSDummy{}
}

// FSMustString is a placeholder for returning files as strings
func FSMustString(_ bool, _ string) string {
	return ""
}
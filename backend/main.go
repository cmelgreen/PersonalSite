package main 

import (
	"context"
	"net/http"
	"os"
	"time"
)

const (
	timeout 		= 5

	portEnvVar 		= "PORT"
	defaultPort		= ":80"

	baseAWSRegion  	= "AWS_REGION"
    baseAWSRoot    	= "AWS_ROOT"
    baseConfigName 	= "base_config"
    baseConfigPath 	= "./app_data/"
	withEncrpytion 	= true
	
	contentDB 		= iota
)

// Create router and environment then serve
func main() {
	ctx, cancelFn := context.WithTimeout(context.Background(), timeout*time.Second)
	defer cancelFn()

	s := newServer(ctx)

	contentDBConfig := dbConfigFromAWS(
		ctx, 
		baseAWSRegion, 
		baseAWSRoot, 
		baseConfigName, 
		baseConfigPath, 
		withEncrpytion,
	)

	s.addDBConnection(ctx, contentDB, contentDBConfig)

	s.mux.GET("/", s.index())
	s.mux.GET("/health", s.healthCheck(contentDB))
	s.mux.GET("/content", s.content(contentDB))
	s.mux.GET("/icon", s.icon())
	s.mux.ServeFiles("/static/*filepath", http.Dir("/frontend/static"))

	port := os.Getenv(portEnvVar)
	if port == "" {
		port = defaultPort
	}

    s.log.Fatal(http.ListenAndServe(port, s.mux))
}
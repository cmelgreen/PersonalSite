package main 

import (
	"context"
	"net/http"
	"os"
	"time"
)

const (
	// Default timeout length
	timeout 		= 5

	// Default environment variable for serving and default port
	portEnvVar 		= "PORT"
	defaultPort		= ":80"

	// AWS SSM path i
	baseAWSRegion  	= "AWS_REGION"
    baseAWSRoot    	= "AWS_ROOT"
    baseConfigName 	= "base_config"
    baseConfigPath 	= "./app_data/"
	withEncrpytion 	= true

	apiRoot 		= "/api"
)

// Create router and environment then serve
func main() {
	ctx, cancelFn := context.WithTimeout(context.Background(), timeout*time.Second)
	defer cancelFn()

	s := newServer(ctx)

	dbConfig := dbConfigFromAWS(
		ctx, 
		baseAWSRegion, 
		baseAWSRoot, 
		baseConfigName, 
		baseConfigPath, 
		withEncrpytion,
	)

	s.newDBConnection(ctx, dbConfig)

	s.log.Println("Setting up routes")

	s.mux.GET("/", s.index())
	s.mux.GET("/health", s.healthCheck())
	s.mux.GET(apiRoot + "/post", s.getPostByID())
	s.mux.GET("/icon", s.icon())
	s.mux.ServeFiles("/static/*filepath", http.Dir("/frontend/static"))

	port := os.Getenv(portEnvVar)
	if port == "" {
		port = defaultPort
	}

	s.log.Println("Running on ", port)

    s.log.Fatal(http.ListenAndServe(port, s.mux))
}
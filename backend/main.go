package main

import (
	"context"
	"html/template"
	"net/http"
	"os"
	"time"

	"PersonalSite/backend/database"
	"PersonalSite/backend/utils"
)

// PULL INTO YAML FILE
const (
	// Default timeout length
	timeout = 10

	// Default environment variable for serving and default port
	portEnvVar  = "PORT"
	defaultPort = ":80"
	frontendDir = "/frontend/static"

	// Environment vars/files to check for AWS CLI & SSM configuration
	baseAWSRegion  = "AWS_REGION"
	baseAWSRoot    = "AWS_ROOT"
	baseConfigName = "base_config"
	baseConfigPath = "./app_data/"
	withEncrpytion = true

	// Path to serve api at
	apiRoot = "/api"
)

// Create router and environment then serve
func main() {
	ctx, cancelFn := context.WithTimeout(context.Background(), timeout*time.Second)
	defer cancelFn()

	s := newServer(ctx)

	dbConfig := database.DBConfigFromAWS{
		BaseAWSRegion:  baseAWSRegion,
		BaseAWSRoot:    baseAWSRoot,
		BaseConfigName: baseConfigName,
		BaseConfigPath: baseConfigPath,
		WithEncrpytion: withEncrpytion,
	}

	s.newDBConnection(ctx, dbConfig)

	fileSystem := FS(false)
	indexHTMLString := FSMustString(false, "/index.html")

	tpl := template.Must(template.New("index").Parse(indexHTMLString))
	s.mux.GET("/", s.staticTemplate(tpl, "index"))
	s.mux.ServeFiles("/static/*filepath", fileSystem)

	s.mux.GET("/health", s.healthCheck())
	s.mux.GET(apiRoot+"/post", s.getPostByID())
	s.mux.POST(apiRoot+"/post", s.createPost())
	s.mux.GET(apiRoot+"/post-summaries", s.getPostSummaries())

	s.setPathsToRedirect(utils.ParseRoutesToRedirect(FSMustByte(false, "/routes.json")))

	port := os.Getenv(portEnvVar)
	if port == "" {
		port = defaultPort
	}

	s.log.Fatal(http.ListenAndServe(port, s.mux))
}

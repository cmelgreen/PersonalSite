package main 

import (
	"context"
	"net/http"
	"os"
)

const (
	portEnvVar = "PORT"
	defaultPort = "80"

	timeout = 5
)

// Create router and environment then serve
func main() {
	ctx, cancelFn := context.WithTimeout(context.Backgroun(), timeout*time.Second)
	defer cancelFn()

	s := newServer(ctx)

	s.mux.GET("/", s.index())
	s.mux.GET("/health", s.healthCheck())
	s.mux.GET("/content", s.content())
	s.mux.GET("/icon", s.icon())
	s.mux.ServeFiles("/static/*filepath", http.Dir("/frontend/static"))

	port := os.Getenv(portEnvVar)
	if port == "" {
		port = ":" + defaultPort
	}

    s.log.Fatal(http.ListenAndServe(port, s.mux))
}
package main 

import (
	"context"
	"net/http"
	"os"
)

// Create router and environment then serve
func main() {
	ctx := context.Background()

	s := newServer(ctx)

	s.mux.GET("/", s.index())
	s.mux.GET("/health", s.healthCheck())
	s.mux.ServeFiles("/static/*filepath", http.Dir("/frontend/static"))

	port := ":80"
	if os.Getenv("PORT") != "" {
		port = os.Getenv("PORT")
	}

    s.log.Fatal(http.ListenAndServe(port, s.mux))
}
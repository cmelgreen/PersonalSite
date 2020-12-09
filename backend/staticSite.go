package main

import (
	"html/template"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func redirectWithCookie(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	http.SetCookie(w, &http.Cookie{Name: "redirect", Value: r.URL.Path, Path: "/"})
	http.Redirect(w, r, "/", http.StatusFound)
}

// ServeStaticSite serves a static site
func (s *Server) ServeStaticSite(index *template.Template, fileSystem http.FileSystem) {
	s.mux.GET("/", staticTemplate(index, "index"))
	s.mux.ServeFiles("/static/*filepath", fileSystem)
}

func (s *Server) setPathsToRedirect(paths []string) {
	for _, path := range paths {
		s.mux.GET(path, redirectWithCookie)
	}
}

// staticTemplate executes the named template passed in
func staticTemplate(tpl *template.Template, name string) httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		tpl.ExecuteTemplate(w, name, nil)
	}
}

// Healthcheck is a closure that returns a function ro check the database connection and write status to user
func (s *Server) healthCheck() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		if s.db.Connected(r.Context()) {
			w.Write([]byte("Connected!"))
		} else {
			http.Error(w, "Error connecting to database", http.StatusNotFound)
			s.log.Println("Error connectiong to database")
		}
	}
}



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

func (s *Server) setPathsToRedirect(paths []string) {
	for _, path := range paths {
		s.mux.GET(path, redirectWithCookie)
	}
}

// staticTemplate executes the named template passed in
func (s *Server) staticTemplate(tpl *template.Template, name string) httprouter.Handle {
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



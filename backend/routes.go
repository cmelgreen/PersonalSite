package main

import (
	"encoding/json"
	"html/template"
	"net/http"

	"PersonalSite/backend/models"

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

func (s *Server) getPostByID() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		r.ParseForm()
		postTitle := r.FormValue("id")

		post, err := s.db.QueryPost(r.Context(), postTitle)
		if err != nil {
			post = models.Post{}
			// IMPLEMENT ERROR HANDLING
		}

		writeJSON(w, post)
	}
}

func (s *Server) createPost() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		r.ParseForm()
		post := models.Post{}

		err := json.NewDecoder(r.Body).Decode(&post)
		if err != nil {
			s.log.Println(err)
			// ADD ERROR HANDLING
		}

		err = s.db.InsertPost(r.Context(), post)
		if err != nil {
			s.log.Println(err)
			// ADD ERROR HANDLING
		}
	}
}

func (s *Server) getPostSummaries() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		postSummaries, err := s.db.QueryPostSummaries(r.Context(), 10)
		if err != nil {
			return
		}

		writeJSON(w, postSummaries)
	}
}

func writeJSON(w http.ResponseWriter, message interface{}) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(message)
}

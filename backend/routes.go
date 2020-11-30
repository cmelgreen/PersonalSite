package main

import (
	"encoding/json"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

// Serve index.html
func (s *Server) index() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		http.ServeFile(w, r, "/frontend/index.html")
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

		p, err := s.db.queryPost(r.Context(), postTitle)
		if err != nil {
			p = post{}
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(p)
	}
}

func (s *Server) icon() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		http.ServeFile(w, r, "/frontend/media/icon.jpg")
	}
}

package main

import (
	"fmt"
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
			fmt.Fprint(w, "Connected!")
		} else {
			http.Error(w, "Error connecting to database", http.StatusNotFound)
			s.log.Println("Error connectiong to database")
		}
	}
}

func (s *Server) content() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		m, err := s.db.queryPost(r.Context())
		if err != nil {
			m = message{"Error fetching data"}
		}

		mes, _ := json.Marshal(m)
		s.log.Println(string(mes))

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(m)
	}
}

func (s *Server) icon() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		http.ServeFile(w, r, "/frontend/media/icon.jpg")
	}
}
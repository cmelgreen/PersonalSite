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
		
		s.log.Println("Raw scan: ", m)
		if err != nil {
			s.log.Println("Error fetching data: ", err)
			m = message{"Error fetching data"}
		}

		s.log.Println("Message: ", m)
		messageBytes, err := json.Marshal(m)
		if err != nil {
			s.log.Println("Error marshalling data: ",err)
		}
		s.log.Println("MessageBytes: ", string(messageBytes))
		w.Write(messageBytes)
	}
}

func (s *Server) icon() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		http.ServeFile(w, r, "/frontend/media/icon.jpg")
	}
}
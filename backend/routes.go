package main

import (
	"fmt"
	"encoding/json"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

type message struct {
	Data string `json:"text"`
}

var lorem = message{"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}

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
		message, err := json.Marshal(lorem)
		if err != nil {
			w.Write([]byte("{data: error"))
		} else {
			w.Write(message)
		}
	}

}
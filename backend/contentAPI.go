package main

import (
	"encoding/json"
	"net/http"

	"PersonalSite/backend/models"

	"github.com/julienschmidt/httprouter"
)

// RichTextHandler is interface for converting Rich Text Editor output to HTML
type RichTextHandler interface{
	RichTextToHTML(string) (string, error)
}

func (s *Server) getPostByID() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		r.ParseForm()
		postTitle := r.FormValue("id")

		post, err := s.db.QueryPost(r.Context(), postTitle)
		if err != nil {
			s.log.Println(err)
			post = models.Post{}
			// IMPLEMENT ERROR HANDLING
		}

		writeJSON(w, post)
	}
}

func (s *Server) createPost(richText RichTextHandler) httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		r.ParseForm()
		post := models.Post{}

		err := json.NewDecoder(r.Body).Decode(&post)
		if err != nil {
			s.log.Println(err)
			// ADD ERROR HANDLING
		}

		html, err := richText.RichTextToHTML(post.Content)
		if err != nil {
			s.log.Println(err)
		}

		post.Content = html

		s.log.Println(post)
		s.log.Println(post.Content)

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
			s.log.Println(err)
		}

		writeJSON(w, postSummaries)
	}
}

func writeJSON(w http.ResponseWriter, message interface{}) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(message)
}
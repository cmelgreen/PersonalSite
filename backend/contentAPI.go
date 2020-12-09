package main

import (
	"encoding/json"
	"net/http"
	"strconv"

	"PersonalSite/backend/models"

	"github.com/julienschmidt/httprouter"
)

// RichTextHandler is interface for converting Rich Text Editor output to HTML
type RichTextHandler interface{
	RichTextToHTML(string) (string, error)
}

func (s *Server) getPostByID() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
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

		post.Content, err = richText.RichTextToHTML(post.RawContent)
		if err != nil {
			s.log.Println(err)
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
		nPostValue := r.FormValue("num-posts")
		nPosts, err := strconv.Atoi(nPostValue)

		if err != nil {
			s.log.Println(err)
			nPosts = -1
		}

		postSummaries, err := s.db.QueryPostSummaries(r.Context(), nPosts)
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
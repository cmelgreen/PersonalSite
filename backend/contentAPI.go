package main

import (
	"encoding/json"
	"net/http"
	"strconv"

	"PersonalSite/backend/models"
	"PersonalSite/backend/utils"

	"github.com/julienschmidt/httprouter"
)

//go:generate go run utils/requestBinding/bindingGenerator.go -f contentAPI.go -out APIBindings.go

// PostRequest is the 
type PostRequest struct {
	Summary 	bool 	`request:"summary"`
	Title		string	`request:"id"`
	Num 		int		`request:"num"`
	Raw			bool	`request:"raw"`
	SortBy		string	`request:"sort-by"`
	FilterBy	string	`request:"filter-by"`
}

// RichTextHandler is interface for converting Rich Text Editor output to HTML
type RichTextHandler interface{
	RichTextToHTML(string) (string, error)
}

func writeStatus(w http.ResponseWriter, statusCode int) {
	w.WriteHeader(statusCode)
}

func writeJSON(w http.ResponseWriter, message interface{}) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(message)
}

func unwrapBool(s string) bool {
	value, err := strconv.ParseBool(s)

	if err != nil {
		return false
	}

	return value
}

// ParsePostRequest takes *http.Request and returns a PostRequest struct
func ParsePostRequest(r *http.Request) (*PostRequest, error) {
	postRequest := &PostRequest{}
	err := utils.UnmarshalRequest(r, postRequest)

	return postRequest, err
}

func (s *Server) getPostByID() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		var request PostRequest 
		utils.UnmarshalRequest(r, &request)

		var post models.Post 
		var err error

		if request.Raw {
			post, err = s.db.QueryPostRaw(r.Context(), request.Title)
		} else {
			post, err = s.db.QueryPost(r.Context(), request.Title)
		}

		if err != nil {
			s.log.Println(err)
			writeStatus(w, 0)
			return
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
			writeStatus(w, 0)
			return
			// ADD ERROR HANDLING
		}

		html, err := richText.RichTextToHTML(post.Content)
		if err != nil {
			s.log.Println(err)
			writeStatus(w, 0)
			return
		}

		post.RawContent = post.Content
		post.Content = html

		err = s.db.InsertPost(r.Context(), post)
		if err != nil {
			s.log.Println(err)
			writeStatus(w, 0)
			return
		}

		writeStatus(w, 200)
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

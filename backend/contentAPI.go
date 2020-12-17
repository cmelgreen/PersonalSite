package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"strings"

	"PersonalSite/backend/models"

	"github.com/julienschmidt/httprouter"
)

// PostRequest is the 
type PostRequest struct {
	Summary 	bool 	`request:"summary"`
	IDs			[]int	`request:"ids"`
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
	r.ParseForm()

	summary, err := strconv.ParseBool(r.FormValue("summary"))
	if err != nil {
		return nil, err
	}

	var ids []int
	for _, idString := range strings.Split(strings.Trim(r.FormValue("ids"), "[]"), ",") {
		id, err := strconv.Atoi(idString)
		if err != nil {
			return nil, err
		}

		ids = append(ids, id)
	}

	num, err := strconv.Atoi(r.FormValue("num"))
	if err != nil {
		return nil, err
	}

	raw, err := strconv.ParseBool(r.FormValue("raw"))
	if err != nil {
		return nil, err
	}

	sortBy := r.FormValue("sort")

	filterBy := r.FormValue("filter")

	postRequest := &PostRequest{
		Summary: 	summary,
		IDs: 		ids,
		Num: 		num,
		Raw: 		raw,
		SortBy: 	sortBy,
		FilterBy: 	filterBy,
	}

	return postRequest, nil
}

func (s *Server) getPostByID() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
		formTitle := r.FormValue("id")

		var post models.Post 
		var err error

		if unwrapBool(r.FormValue("raw")) {
			post, err = s.db.QueryPostRaw(r.Context(), formTitle)
		} else {
			post, err = s.db.QueryPost(r.Context(), formTitle)
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

		post.Content, err = richText.RichTextToHTML(post.RawContent)
		if err != nil {
			s.log.Println(err)
			writeStatus(w, 0)
			return
		}

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
		nPostValue := r.FormValue("numPosts")
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

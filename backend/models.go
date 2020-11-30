package main 

type post struct {
	Title 		string `json:"title" db:"title"`
	Content 	string `json:"content" db:"content"`
}

type postList struct {
	Posts 		[]post `'json:"posts"`
}
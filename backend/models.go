package main 

type route struct {
	Path 		string 	`json:"path"`
	Redirect 	bool 	`json:"redirect"`
}

type routeFile struct {
	Routes		[]*route	`json:"routes"`
}

type post struct {
	Title 		string `json:"title" db:"title"`
	Content 	string `json:"content" db:"content"`
}

type postList struct {
	Posts 		[]post `json:"posts"`
}
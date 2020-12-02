package main 

type route struct {
	Path 		string 	`json:"path"`
	Redirect 	bool 	`json:"redirect"`
}

type routeFile struct {
	Routes		[]*route	`json:"routes"`
}

type post struct {
	ID			int    	`json:"id" db:"id"`
	Title 		string 	`json:"title" db:"title"`
	Summary		string 	`json:"summary" db:"summary"`
	Content 	string 	`json:"content" db:"content"`
}

type postList struct {
	Posts 		[]post `json:"posts"`
}
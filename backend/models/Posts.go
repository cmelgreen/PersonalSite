package models

// Route is the path and redirect value for frontend browswer routes
type Route struct {
	Path 		string 	`json:"path"`
	Redirect 	bool 	`json:"redirect"`
}

// RouteFile is a list of Routes
type RouteFile struct {
	Routes		[]*Route	`json:"routes"`
}

// Post is the main structure served and displayed
type Post struct {
	ID			int    	`json:"id" db:"id"`
	Title 		string 	`json:"title" db:"title"`
	Summary		string 	`json:"summary" db:"summary"`
	Content 	string 	`json:"content" db:"content"`
	RawContent  string	`json:"rawContent" db:"rawContent"`
}

// PostList is a list of Posts
type PostList struct {
	Posts 		[]*Post `json:"posts"`
}
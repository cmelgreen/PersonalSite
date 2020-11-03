package main 

type message struct {
	Data string `json:"text" db:"content"`
}
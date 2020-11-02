package main

import (
	"log"
	"net/http"
	
	"github.com/julienschmidt/httprouter"
)

func main() {
	router := httprouter.New()

	router.GET("/", index)
	router.ServeFiles("/static/*filepath", http.Dir("/frontend/static"))

	log.Fatal(http.ListenAndServe(":80", router))

}

func index(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	http.ServeFile(w, r, "/frontend/index.html")
}

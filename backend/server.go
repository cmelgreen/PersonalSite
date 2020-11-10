package main

import (
	"context"
	"log"
	"os"
	"time"
	
	"github.com/julienschmidt/httprouter"
)

const (
	heartbeatTime = 10
)

var (
	logOut = os.Stdout
	logPrefix = log.Prefix()
	logFlags = log.Flags()
)

// Server struct for storing database, mux, and logger
type Server struct{
    db map[int]*Database
    mux *httprouter.Router
    log *log.Logger
}

func newServer(ctx context.Context) *Server {
	s := Server{
        log: log.New(logOut, logPrefix, logFlags),
        mux: httprouter.New(),
    }

	return &s
}

func (s *Server) addDBConnection(ctx context.Context, id int, dbConfig DBConfig) {
	db, err := ConnectToDB(ctx, dbConfig)
    if err != nil {
        s.log.Println(err)
    }

	s.db[id] = db

	err = s.db[id].createTable(ctx)
	if err != nil {
		s.log.Println("Error creating table: ", err)
	}

	s.maintainDBConnection(ctx, id, dbConfig)
}

func (s *Server) maintainDBConnection(ctx context.Context, id int, dbConfig DBConfig) {
	go func() {
		var err error
		for {
			if s.db[id].Connected(ctx) != true {
				s.db[id], err = ConnectToDB(ctx, dbConfig)
				if err != nil {
					s.log.Println("Error maintaining connection: ", err)
				}
			}

			time.Sleep(heartbeatTime * time.Second)
		}
	}()
}
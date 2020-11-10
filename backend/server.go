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
    db *Database
    mux *httprouter.Router
    log *log.Logger
}

func newServer(ctx context.Context) *Server {
	s := Server{
        log: log.New(logOut, logPrefix, logFlags),
		mux: httprouter.New(),
		db: &Database{},
    }

	return &s
}


func (s *Server) newDBConnection(ctx context.Context, dbConfig DBConfig) {
	var err error

	s.db, err = ConnectToDB(ctx, dbConfig)
    if err != nil {
        s.log.Println(err)
    }

	err = s.db.createTable(ctx)
	if err != nil {
		s.log.Println("Error creating table: ", err)
	}

	s.maintainDBConnection(ctx, dbConfig)
}

func (s *Server) maintainDBConnection(ctx context.Context, dbConfig DBConfig) {
	go func() {
		var err error
		for {
			if s.db.Connected(ctx) != true {
				s.db, err = ConnectToDB(ctx, dbConfig)
				if err != nil {
					s.log.Println("Error maintaining connection: ", err)
				}
			}

			time.Sleep(heartbeatTime * time.Second)
		}
	}()
}
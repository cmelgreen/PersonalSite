package main

import (
	"context"

	_ "github.com/jackc/pgx/v4/stdlib"

	"github.com/jmoiron/sqlx"
)

const (
	sqlDriver = "pgx"
)

// Database abstracts sqlx connection
type Database struct {
	*sqlx.DB
}

// DBConfig abstracts generation of a database configuration string
type DBConfig interface {
	ConfigString(context.Context) (string, error)
}

// ConnectToDB creates a db connection with any predefined timeout
func ConnectToDB(ctx context.Context, dbConfig DBConfig) (*Database, error) {
	config, err := dbConfig.ConfigString(ctx)
	if err != nil {
		return &Database{}, err
	}

	conn, err := sqlx.ConnectContext(ctx, sqlDriver, config)
	if err != nil {
		return &Database{}, err
	}

	return &Database{conn}, nil
}

// Connected pings server and returns bool response status
func (db *Database) Connected(ctx context.Context) bool {
	if *db == (Database{}) {
		return false
	}

	err := db.PingContext(ctx)

	if err != nil {
		return false
	}

	return true
}

func (db *Database) createTable(ctx context.Context) error {
	schema := `CREATE TABLE post(
		content varchar(1000)
	)`

	_, err := db.ExecContext(ctx, schema)

	if err != nil {
		return err
	}

	lorem := "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum."
	insertQuery := "INSERT INTO post(content) VALUES ($1);"

	_, err = db.ExecContext(ctx, insertQuery, lorem)

	if err != nil {
		return err
	}

	return nil
}

func (db *Database) queryPost(ctx context.Context) (message, error) {
	m := message{}

	query := "SELECT * FROM post;"
	err := db.QueryRowxContext(ctx, query).Scan(&m.Data)

	return m, err
}
package main

import (
	"context"
	"fmt"

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

// DBConfigFromValues is the default DBConfig type using set values
type dbConfigFromValues struct {
	database	  	string
	host    		string
	port 			string
	user 			string
	password		string
}

// ConfigString returns DBConfigValues formatted into a configuartion string
func (dbConfig dbConfigFromValues) ConfigString(ctx context.Context) (string, error) {
	configString := fmt.Sprintf(
	"database=%s host=%s port=%s user=%s password=%s",
	dbConfig.database,
	dbConfig.host,
	dbConfig.port,
	dbConfig.user,
	dbConfig.password,
	)
	
	return configString, nil
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
		title varchar(1000) PRIMARY KEY,
		content varchar(1000)
	)`

	_, err := db.ExecContext(ctx, schema)

	// CHECK ERROR IS ALREADY CREATED OR OTHER

	defaultPosts := postList{
		[]post{
			{"AAA", "Post 1 is fun"},
			{"BBB", "Post 2 for you"},
			{"CCC", "Post 3 for me"},
		},
	}
	
	insertQuery := "INSERT INTO post(title, content) VALUES ($1, $2);"

	for _, post := range defaultPosts.Posts {
		if _, err = db.ExecContext(ctx, insertQuery, post.Title, post.Content); err != nil {
			return err
		}
	}
	
	return nil
}

func (db *Database) queryPost(ctx context.Context, title string) (post, error) {
	p := post{}

	query := "SELECT * FROM post WHERE title=$1;"
	err := db.QueryRowxContext(ctx, query, title).Scan(&p.Title, &p.Content)

	return p, err
}
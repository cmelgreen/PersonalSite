package database

import (
	"context"
	"fmt"

	"PersonalSite/backend/models"

	// Database driver for db interactions
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

// CreateTable creates default tables
func (db *Database) CreateTable(ctx context.Context) error {
	schema := `
	CREATE TABLE post(
		id int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
		title varchar(255) UNIQUE,
		summary varchar(255),
		content text
	);
	
	CREATE TABLE tag(
		id int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
		value varchar(50)
	);
	
	CREATE TABLE post_tag(
		post_id int REFERENCES post (id),
		tag_id int REFERENCES tag (id)
	);`

	_, err := db.ExecContext(ctx, schema)

	// CHECK ERROR IS ALREADY CREATED OR OTHER

	insertQuery := `
	INSERT INTO post (title, summary, content)
	VALUES 
		('AAA', 'aaa', 'Post 1 is fun'),
		('BBB', 'bbb', 'Post 2 for you'),
		('CCC', 'ccc', 'Post 3 for me'),
		('DDD', 'ddd', 'Post 4 some more');
		
	INSERT INTO tag (value)
	VALUES 
		('letter a'),
		('letter b/c');
		
	INSERT INTO post_tag
	SELECT post.id, tag.id
	FROM post CROSS JOIN tag
	WHERE post.title in ('BBB', 'CCC')
		AND tag.value = 'letter b/c';
		
	INSERT INTO post_tag
	SELECT post.id, tag.id
	FROM post CROSS JOIN tag
	WHERE post.title  = 'AAA'
		AND tag.value IN ('letter a', 'LET A');
	`

	if _, err = db.ExecContext(ctx, insertQuery); err != nil {
		return err
	}
	
	return nil
}

// QueryPost queries single post
func (db *Database) QueryPost(ctx context.Context, title string) (models.Post, error) {
	post := models.Post{}

	query := "SELECT * FROM post WHERE title=$1;"
	err := db.SelectContext(ctx, &post, query, title)

	return post, err
}

// QueryPostSummaries returns N post summaries with title and post id
func (db *Database) QueryPostSummaries(ctx context.Context, nPosts int) (models.PostList, error) {
	var posts []*models.Post
	
	query := "SELECT * FROM post LIMIT $1;"
	err := db.SelectContext(ctx, &posts, query, nPosts)

	return models.PostList{Posts: posts}, err
}
package main

import (
	"context"
	"fmt"

	"github.com/spf13/viper"
)

var ssmParams = []string{
	"database",
	"host",
	"port",
	"user",
	"password",
}

// DBConfigFromAWS implements DBConfig
type DBConfigFromAWS struct {
	DBConfig

	baseAWSRegion  string
	baseAWSRoot    string
	baseConfigName string
	baseConfigPath string

	withEncrpytion bool
}

func dbConfigFromAWS(ctx context.Context, region, root, config, path string, withEncrpytion bool) DBConfigFromAWS {
	return DBConfigFromAWS{
		baseAWSRegion:  region,
		baseAWSRoot:    root,
		baseConfigName: config,
		baseConfigPath: path,
		withEncrpytion: withEncrpytion}
}

// ConfigString returns database connection string based on AWS_ROOT and remote SSM parameters
func (dbConfig DBConfigFromAWS) ConfigString(ctx context.Context) (string, error) {
	err := dbConfig.loadBaseConfigFromDotEnv()
	if err != nil {
		return "", err
	}

	awsRegion := viper.GetString(dbConfig.baseAWSRegion)
	ssmRoot := viper.GetString(dbConfig.baseAWSRoot)

	svc := newSSM(awsRegion)

	params, err := svc.getParams(ctx, withEncrpytion, ssmRoot, ssmParams)
	if err != nil {
		return "", err
	}

	configString := fmt.Sprintf(
		"database=%s host=%s port=%s user=%s password=%s",
		params["database"],
		params["host"],
		params["port"],
		params["user"],
		params["password"],
	)

	return configString, nil
}

// Pull AWS_ROOT and AWS_REGION from .env file
func (dbConfig DBConfigFromAWS) loadBaseConfigFromDotEnv() error {
	viper.SetConfigName(dbConfig.baseConfigName)
	viper.AddConfigPath(dbConfig.baseConfigPath)

	err := viper.ReadInConfig()
	if err != nil {
		return err
	}

	return nil
}

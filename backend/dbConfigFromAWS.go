package main

import (
    "context"
    "fmt"

    "github.com/spf13/viper"
)

const (
    baseRegion  = "AWS_REGION"
    baseRoot    = "AWS_ROOT"
    baseConfig  = "base_config"
    basePath    = "./app_data/"

    withEncrpytion = true
)

var ssmParams = []string{
    "database",
    "host",
    "port",
    "user",
    "password",

}

type DBConfigFromAWS struct {}

func (dbConfig *dbConfigFromAWS) ConfigString(ctx context.Context) (string, error) {
    return configStringFromAWS(ctx)
}

// ConfigString returns database connection string based on AWS_ROOT and remote SSM parameters
func configStringFromAWS(ctx context.Context) (string, error) {
	err := loadBaseConfig()
	if err != nil {
		return "", err
    }
    
    awsRegion := viper.GetString(baseRegion)
    ssmRoot := viper.GetString(baseRoot)

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
func loadBaseConfig() error {
    viper.SetConfigName(baseConfig)
    viper.AddConfigPath(basePath)

    err := viper.ReadInConfig()
    if err != nil {
        return err
	}
	
	return nil
}


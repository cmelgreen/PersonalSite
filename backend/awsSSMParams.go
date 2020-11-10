package main

import (
	"context"
	"strings"

	"github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/ssm"
)

type awsSSM struct {
    *ssm.SSM
}

// newSSM creates a new AWS connection returns a Simple Service Manager session
func newSSM(region string) *awsSSM {
    sess := session.New()

    return &awsSSM{ssm.New(sess, 
        &aws.Config{
            Region: aws.String(region),
    })}

}

// getParams returns map of key:value SSM Parameters as listed in paramsToGet along with any error fectching them
func (svc *awsSSM) getParams(ctx context.Context, encrpyted bool, root string, paramsToGet []string) (map[string]string, error) {
    params := make(map[string]string, len(paramsToGet))
    var paramsToGetPaths []*string

    for _, paramToGet := range paramsToGet {
        paramPath := root + paramToGet
        paramsToGetPaths = append(paramsToGetPaths, &paramPath)
    } 
    
    output, err := svc.GetParametersWithContext(ctx, 
            &ssm.GetParametersInput{
                Names: paramsToGetPaths,
                WithDecryption: aws.Bool(encrpyted),
    })

    for _, param := range output.Parameters {
        key := strings.TrimPrefix(*param.Name, root)
        val := *param.Value
        params[key] = val
    }
    
    return params, err
}
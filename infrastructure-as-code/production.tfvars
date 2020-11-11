AWS_REGION                  = "us-west-2"
AWS_AZ                      = "us-west-2a"
AWS_BACKUP_AZ               = "us-west-2b"

GITHUB_OWNER                = "cmelgreen"
GITHUB_CREDENTIALS          = "credentials/github"

BUILD_SERVER_NAME           = "build-server"
BUILD_SERVER_AMI            = "ami-04ddade76a44c06c3"
BUILD_SERVER_USER_DATA      = "scripts/build_server.sh"

DEPLOYMENT_GROUP_NAME       = "deploymnet-server-group"
DEPLOYMENT_GROUP_AMI        = "ami-04ddade76a44c06c3"
DEPLOYMENT_GROUP_USER_DATA  = "scripts/deployment_server.sh"
DEPLOYMENT_GROUP_KEY        = "zoff.pem"

DB_IDENTIFIER               = "personal-site-db"
DB_PASSWORD                 = "credentials/rds"

CODEDEPLOY_NAME             = "server-app"
CODEDEPLOY_BUCKET           = "server-app-bucket"
CODEDEPLOY_GROUP_NAME       = "server-app-group"
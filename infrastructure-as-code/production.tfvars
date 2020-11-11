AWS_REGION                  = "us-west-2"
AWS_AZ                      = "us-west-2a"
AWS_BACKUP_AZ               = "us-west-2b"

GITHUB_CREDENTIALS          = "credentials/github"
GITHUB_OWNER                = "cmelgreen"
GITHUB_REPO                 = "PersonalSite"

BUILD_SERVER_NAME           = "build-server"
BUILD_SERVER_AMI            = "ami-04ddade76a44c06c3"
BUILD_SERVER_USER_DATA      = "scripts/build_server.sh"

DEPLOYMENT_GROUP_NAME       = "deploymnet-server-group"
DEPLOYMENT_GROUP_AMI        = "ami-04ddade76a44c06c3"
DEPLOYMENT_GROUP_USER_DATA  = "scripts/deployment_server.sh"
DEPLOYMENT_GROUP_KEY        = "zoff"

DB_IDENTIFIER               = "personal-site-db"
DB_PASSWORD                 = "credentials/rds"

CODEDEPLOY_NAME             = "personal-site"
CODEDEPLOY_BUCKET           = "personal-site-codedeploy-bucket"
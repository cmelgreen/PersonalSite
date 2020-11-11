AWS_REGION                  = "us-west-2"
AWS_AZ                      = "us-west-2a"
AWS_BACKUP_AZ               = "us-west-2b"

GITHUB_OWNER                = "cmelgreen"
GITHUB_CREDENTIALS          = "credentials/github")

BUILD_SERVER_NAME           = "build_server"
BUILD_SERVER_AMI            = "ami-04ddade76a44c06c3"
BUILD_SERVER_USER_DATA      = file("scripts/build_server.sh")

DEPLOYMENT_GROUP_NAME       = "deploymnet_server_group"
DEPLOYMENT_GROUP_AMI        = "ami-04ddade76a44c06c3"
DEPLOYMENT_GROUP_USER_DATA  = templatefile("scripts/deployment_server.sh", {region = var.AWS_REGION})
DEPLOYMENT_GROUP_KEY        = "zoff.pem"

CODEDEPLOY_NAME                = "server-app"
CODEDEPLOY_BUCKET              = "server-app-bucket"
CODEDEPLOY_GROUP               = "server-app-group"
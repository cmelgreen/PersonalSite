AWS_REGION                  = "us-west-2"

#SERVER_IMAGE                = "ami-02cac8e5519ce651f"
SERVER_IMAGE                = "ami-04ddade76a44c06c3"
SERVER_INSTANCE_TYPE        = "t2.micro"
SERVER_USER_DATA            = "./user_data.sh"
SERVER_KEY                  = "zoff"
SERVER_VOL_TYPE             = "gp2"
SERVER_VOL_SIZE             = 30
SERVER_PUBLIC_IP            = false

BACKEND_INSTANCE_TYPE       = "t2.medium"
BACKEND_IAM_ROLE            = "backend_iam_role"
BACKEND_IAM_POLICY          = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
          "Service": [
          "ec2.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

SERVER_ASG_MIN              = 1
SERVER_ASG_MAX              = 1
SEVER_ASG_DEFAULT           = 1
SERVER_ASG_HEALTH_PERIOD    = 30
SERVER_ASG_HEALTH_TYPE      = "EC2"
SERVER_ASG_FORCE            = true

SERVER_IAM_NAME             = "ServerIam"
SERVER_IAM_FORCE_DETATCH    = true
SERVER_IAM_POLICY           = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Sid": "",
    "Effect": "Allow",
    "Principal": {
        "Service": [
        "ec2.amazonaws.com"
        ]
    },
    "Action": "sts:AssumeRole"
    }
]
}
EOF

APP_NAME                = "server-app"
APP_BUCKET              = "server-app-bucket"
APP_GROUP               = "server-app-group"
APP_ROLLBACK            = true
APP_ROLLBACK_EVENTS     = ["DEPLOYMENT_FAILURE"]

IAM_FULL_SSM_ARN        = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
IAM_READ_ONLY_SSM_ARN   = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
IAM_FULL_S3_ARN         = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
IAM_CD_EC2_ARN          = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
IAM_CD_DEPLOYER_ARN     = "arn:aws:iam::aws:policy/AWSCodeDeployDeployerAccess"
IAM_CD_DEPLOY_ARN       = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"


VPC_CIDR                = "10.0.0.0/16"
VPC_DN_SUPPORT          = true
VPC_DNS_HOSTNAMES       = true

PUBLIC_SUBNET_CIDR      = "10.0.1.0/24"
PUBLIC_SUBNET_MAP_IP    = true
PUBLIC_SUBNET_AZ        = "us-west-2a"

PRIVATE_SUBNET_CIDR     = "10.0.2.0/24"
PRIVATE_SUBNET_AZ       = "us-west-2a"

BACKUP_SUBNET_CIDR      = "10.0.3.0/24"
BACKUP_SUBNET_AZ        = "us-west-2b"


ELB_PORT                = 80
ELB_PROTOCOL            = "HTTP"
ELB_INSTANCE_PORT      = 80
ELB_INSTANCE_PROTOCOL   = "HTTP"

HEALTH_THRESHOLD        = 2
UNHEALTH_THRESHOLD      = 2
HEALTH_TIMEOUT          = 3
HEALTH_INTERVAL         = 30


RDS_INDENTIFIER         = "test5"
RDS_USERNAME            = "postgres"
RDS_PASSWORD            = "postgres"
RDS_SNAPSHOT_NAME       = "foo"
RDS_SNAPSHOT_SKIP       = true
RDS_ALLOCATED_STORAGE   = 5
RDS_STORAGE_TYPE        = "gp2"
RDS_INSTANCE_CLASS      = "db.t2.micro"
RDS_ENGINE              = "postgres"
RDS_ENGINE_VERSION      = "9.6.9"
RDS_PUBLIC_ACCESS       = false
RDS_PORT                = 5432
RDS_CIDR                = "0.0.0.0/0"

PARAM_ROOT              = "/rds/"

GITHUB_TOKEN            = #"1382d38f1ac1b599a26279a64f8080cd3380ef10"
GITHUB_OWNER            = "cmelgreen"
GITHUB_REPO             = "PersonalSite"
GITHUB_CONTENT_TYPE     = "json"
GITHUB_INSECURE_SSL     = true
GITHUB_EVENTS           =  ["push"]

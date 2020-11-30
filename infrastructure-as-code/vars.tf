variable "AWS_REGION" {
    type    = string
}
variable "AWS_AZ" {
    type    = string
}
variable "AWS_BACKUP_AZ" {
    type    = string
}

variable "GITHUB_CREDENTIALS" {
    type    = string
}
variable "GITHUB_OWNER" {
    type    = string
}
variable "GITHUB_REPO" {
    type    = string
}

variable "BUILD_SERVER_NAME" {
    type    = string
}
variable "BUILD_SERVER_AMI" {
    type    = string
}
variable "BUILD_SERVER_USER_DATA" {
    type    = string
}
variable "BUILD_SERVER_INSTANCE" {
    type    = string
    default = "t2.small"
}
variable "BUILD_SERVER_KEY" {
    type    = string
    default = ""
}

variable "DEPLOYMENT_GROUP_NAME" {
    type    = string
}
variable "DEPLOYMENT_GROUP_AMI" {
    type    = string
}
variable "DEPLOYMENT_GROUP_USER_DATA" {
    type    = string
}
variable "DEPLOYMENT_GROUP_KEY" {
    type    = string
    default = ""
}

variable "DB_IDENTIFIER" {
    type    = string
}
variable "DB_USERNAME" {
    type     = string
    default  = "postgres"
}
variable "DB_PASSWORD_FILE" {
    type     = string
}
variable "DB_PUBLIC_ACCESS" {
    type    = bool
    default = false
}

variable "CODEDEPLOY_NAME" {
    type    = string
}
variable "CODEDEPLOY_BUCKET" {
    type    = string
}

variable "IAM_FULL_SSM_ARN" {
    type    =  string
    default = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
variable "IAM_READ_ONLY_SSM_ARN" {
    type    =  string
    default = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}
variable "IAM_FULL_S3_ARN" {
    type    =   string
    default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
variable "IAM_CD_EC2_ARN" {
    type    = string
    default = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}
variable "IAM_CD_DEPLOYER_ARN" {
    type    = string
    default = "arn:aws:iam::aws:policy/AWSCodeDeployDeployerAccess"
}
variable "IAM_CD_DEPLOY_ARN" {
    type    = string
    default = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}


variable "EC2_CODEDEPLOY_POLICY" {
    type    = string

    // No extra spaces allowed
    default = <<EOF
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
}

variable "VPC_CIDR" {
    type    = string
    default = "10.0.0.0/16"
}
variable "VPC_DN_SUPPORT" {
    type    = bool
    default = true
}
variable "VPC_DNS_HOSTNAMES" {
    type    = bool
    default = true
}

variable "PUBLIC_SUBNET_CIDR" {
    type    = string
    default = "10.0.1.0/24"
}
variable "PUBLIC_SUBNET_MAP_IP" {
    type    = bool
    default = true
}
variable "PRIVATE_SUBNET_CIDR" {
    type    = string
    default = "10.0.2.0/24"
}
variable "BACKUP_SUBNET_CIDR" {
    type    = string
    default = "10.0.3.0/24"
}
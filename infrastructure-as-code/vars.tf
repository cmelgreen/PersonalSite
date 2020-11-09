variable "AWS_REGION" {}



variable "IAM_FULL_SSM_ARN" {}
variable "IAM_READ_ONLY_SSM_ARN" {}
variable "IAM_FULL_S3_ARN" {}
variable "IAM_CD_EC2_ARN" {}
variable "IAM_CD_DEPLOYER_ARN" {}
variable "IAM_CD_DEPLOY_ARN" {}


variable "VPC_CIDR" {}
variable "VPC_DN_SUPPORT" {}
variable "VPC_DNS_HOSTNAMES" {}

variable "PUBLIC_SUBNET_CIDR" {}
variable "PUBLIC_SUBNET_MAP_IP" {}
variable "PUBLIC_SUBNET_AZ" {}

variable "PRIVATE_SUBNET_CIDR" {}
variable "PRIVATE_SUBNET_AZ" {}

variable "BACKUP_SUBNET_CIDR" {}
variable "BACKUP_SUBNET_AZ" {}
     
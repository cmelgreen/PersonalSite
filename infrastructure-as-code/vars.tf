variable "AWS_REGION" {}


variable "SERVER_IMAGE" {}             
variable "SERVER_INSTANCE_TYPE" {}     
variable "SERVER_USER_DATA" {}        
variable "SERVER_KEY" {}
variable "SERVER_VOL_TYPE" {}
variable "SERVER_VOL_SIZE" {}
variable "SERVER_PUBLIC_IP" {}

variable "BACKEND_USER_DATA" {}
variable "BACKEND_INSTANCE_TYPE" {}
variable "BACKEND_IAM_ROLE" {}
variable "BACKEND_IAM_POLICY" {}

variable "SERVER_ASG_MIN" {}
variable "SERVER_ASG_MAX" {}
variable "SEVER_ASG_DEFAULT" {}
variable "SERVER_ASG_HEALTH_PERIOD" {}
variable "SERVER_ASG_HEALTH_TYPE" {}
variable "SERVER_ASG_FORCE" {}

variable "APP_NAME" {}
variable "APP_BUCKET" {}
variable "APP_GROUP" {}
variable "APP_ROLLBACK" {}
variable "APP_ROLLBACK_EVENTS" {}


variable "SERVER_IAM_NAME" {}
variable "SERVER_IAM_FORCE_DETATCH" {}
variable "SERVER_IAM_POLICY" {}

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


variable "ELB_PORT" {}
variable "ELB_PROTOCOL" {}
variable "ELB_INSTANCE_PORT" {}
variable "ELB_INSTANCE_PROTOCOL" {}

variable "HEALTH_THRESHOLD" {}
variable "UNHEALTH_THRESHOLD" {}
variable "HEALTH_TIMEOUT" {}
variable "HEALTH_INTERVAL" {}


variable "RDS_INDENTIFIER" {}
variable "RDS_ALLOCATED_STORAGE" {}
variable "RDS_CIDR" {}
variable "RDS_STORAGE_TYPE" {}
variable "RDS_ENGINE" {}
variable "RDS_ENGINE_VERSION" {}
variable "RDS_PORT" {}
variable "RDS_INSTANCE_CLASS" {}
variable "RDS_PUBLIC_ACCESS" {}
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_SNAPSHOT_NAME" {}
variable "RDS_SNAPSHOT_SKIP" {}

variable "PARAM_ROOT" {}

variable "GITHUB_TOKEN" {}
variable "GITHUB_OWNER" {}
variable "GITHUB_REPO" {}
variable "GITHUB_CONTENT_TYPE" {}
variable "GITHUB_INSECURE_SSL" {}
variable "GITHUB_EVENTS" {}           
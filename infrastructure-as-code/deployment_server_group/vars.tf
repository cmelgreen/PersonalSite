variable "SERVER_IMAGE" {}             
variable "SERVER_INSTANCE_TYPE" {}     
variable "SERVER_USER_DATA" {}        
variable "SERVER_KEY" {}
variable "SERVER_VOL_TYPE" {}
variable "SERVER_VOL_SIZE" {}
variable "SERVER_PUBLIC_IP" {}

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

variable "ELB_PORT" {}
variable "ELB_PROTOCOL" {}
variable "ELB_INSTANCE_PORT" {}
variable "ELB_INSTANCE_PROTOCOL" {}

variable "HEALTH_THRESHOLD" {}
variable "UNHEALTH_THRESHOLD" {}
variable "HEALTH_TIMEOUT" {}
variable "HEALTH_INTERVAL" {}
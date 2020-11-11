variable "NAME" {
    type    = string
}
variable "LC_NAME" {
    type    = string
    default = "${var.NAME}_${formatdate("YY_MM_DD_HH_mm", timestamp())}"
}
variable "LC_SG" {
    type    = string
}
variable "IMAGE" {
    type    = string
    default = "ami-07dd19a7900a1f049" // default Ubunut Server 20.04 LTS
}             
variable "INSTANCE_TYPE" {
    type    = string
    default = "t2.micro"
}     
variable "USER_DATA" {
    type    = string
    default = ""
}        
variable "KEY" {
    type    = string
    default = ""
}
variable "VOL_TYPE" {
    type    = string
    default = "gp2"
}
variable "VOL_SIZE" {    
    type    = number
    default = 30
}
variable "PUBLIC_IP" {
    type    = bool
    default = true
}
variable "VPC" {
    type    = string
}
variable "ASG_MIN" {
    type    = number
    default = 1
}
variable "ASG_MAX" {
    type    = number
    default = 1
}
variable "ASG_DESIRED" {
    type    = number
    default = 1
}
variable "ASG_HEALTH_PERIOD" {
    type    = number
    default = 30
}
variable "ASG_HEALTH_TYPE" {
    type    = string
    default = "EC2"
}
variable "ASG_FORCE" {
    type    = bool
    default = true
}
variable "ELB_SG" {
    type    = string
}
variable "ELB_SUBNETS" {
    type    = string
}
variable "ELB_PORT" {
    type    = number
    default = 80
}
variable "ELB_PROTOCOL" {
    type    = string
    default = "HTTP"
}
variable "ELB_INSTANCE_PORT" {
    type    = number
    default = 80
}
variable "ELB_INSTANCE_PROTOCOL" {
    type    = string
    default = "HTTP"
}

variable "HEALTH_THRESHOLD" {
    type    = number
    default = 2
}
variable "UNHEALTH_THRESHOLD" {
    type    = number
    default = 2
}
variable "HEALTH_TIMEOUT" {
    type    = number
    default = 3
}
variable "HEALTH_INTERVAL" {
    type    = number
    default = 30
}

variable "IAM_POLICIES" {
    type    = list(string)
    default = []
}
variable "IAM_BASE_POLICY" {
    type    = string
    default = <<EOF
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
}
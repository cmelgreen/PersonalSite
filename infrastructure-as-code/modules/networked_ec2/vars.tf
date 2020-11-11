variable "AMI" {
    type    = string
}
variable "USER_DATA" {
    type    = string
    default = ""
}
variable "INSTANCE_TYPE" {
    type    = string
    default = "t2.micro"
}
variable "PUBLIC_IP" {
    type    = bool
    default = true
}
variable "KEY" {
    type    = string
    default = ""
}           
variable "SUBNET" {
    type    = string

}          
variable "VPC_SG_IDS" {
    type    = list(string)
    default = []
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
variable "IDENTIFIER" {
    type    = string
}
variable "USERNAME" {
    type    = string
}
variable "PASSWORD" {
    type    = string
}
variable "ALLOCATED_STORAGE" {
    type    = number
    default = 5
}
variable "CIDR" {
    type    = string
    default = "0.0.0.0/0"
}
variable "VPC" {
    type    = string
}
variable "STORAGE_TYPE" {
    type    = string
    default = "gp2"
}
variable "ENGINE" {
    type    = string
    default = "postgres"
}
variable "ENGINE_VERSION" {
    type    = string
    default = "10.14"
}
variable "PORT" {
    type    = number
    default = 5432
}
variable "INSTANCE_CLASS" {
    type    = string
    default = "db.t2.micro"
}
variable "PUBLIC_ACCESS" {
    type    = bool
    default = false
}
variable "SNAPSHOT_NAME" {
    type    = string
    default = "snapshot"
}
variable "SNAPSHOT_SKIP" {
    type    = bool
    default = true
}
variable "SUBNETS" {
    type    = list(string)
    default = []
}
variable "INGRESS_SGS" {
    type    = list(string)
    default = []
}
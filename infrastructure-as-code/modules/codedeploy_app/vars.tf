variable "NAME" {
    type    = string

}
variable "BUCKET" {
    type    = string
}
variable "SERVICE_ROLE" {
    type    = string
}
variable "ASG" {
    type    = list(string)
}
variable "ROLLBACK" {
    type    = bool
    default = true
}
variable "ROLLBACK_EVENTS" {
    type    = list(string)
    default = ["DEPLOYMENT_FAILURE"]
}
variable "REPO" {
    type    = string
}
variable "TARGET_IP" {
    type    = string
}
variable "CONTENT_TYPE" {
    type    = string
    default = "json"
}
variable "INSECURE_SSL" {
    type    = bool
    default = true
}
variable "EVENTS" {
    type    = list(string)
    default = ["push"]
}
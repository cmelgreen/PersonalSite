resource "aws_ssm_parameter" "rds_user" {
    name        = "${var.PARAM_ROOT}user"
    type        = "SecureString"
    value       = var.RDS_USERNAME
}

resource "aws_ssm_parameter" "rds_password" {
    name        = "${var.PARAM_ROOT}password"
    type        = "SecureString"
    value       = var.RDS_PASSWORD
}

resource "aws_ssm_parameter" "rds_port" {
    name        = "${var.PARAM_ROOT}port"
    type        = "SecureString"
    value       = var.RDS_PORT
}

resource "aws_ssm_parameter" "rds_host" {
    name        = "${var.PARAM_ROOT}host"
    type        = "SecureString"
    value       = aws_db_instance.rds.address
}

resource "aws_ssm_parameter" "rds_database" {
    name        = "${var.PARAM_ROOT}database"
    type        = "SecureString"
    value       = var.RDS_ENGINE
}

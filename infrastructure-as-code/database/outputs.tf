output "rds_prod_endpoint" {
    value = aws_db_instance.rds.address
}

resource "aws_ssm_parameter" "rds_user" {
    name        = "${var.AWS_SSM_ROOT}/user"
    type        = "SecureString"
    value       = var.RDS_USERNAME
}

resource "aws_ssm_parameter" "rds_password" {
    name        = "${var.AWS_SSM_ROOT}/password"
    type        = "SecureString"
    value       = var.RDS_PASSWORD
}

resource "aws_ssm_parameter" "rds_port" {
    name        = "${var.AWS_SSM_ROOT}/port"
    type        = "SecureString"
    value       = var.RDS_PORT
}

resource "aws_ssm_parameter" "rds_host" {
    name        = "${var.AWS_SSM_ROOT}/host"
    type        = "SecureString"
    value       = aws_db_instance.rds.address
}

resource "aws_ssm_parameter" "rds_database" {
    name        = "${var.AWS_SSM_ROOT}/database"
    type        = "SecureString"
    value       = var.RDS_ENGINE
}
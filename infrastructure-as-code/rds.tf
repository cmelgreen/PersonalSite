resource "aws_db_instance" "rds" {
      identifier                = var.RDS_INDENTIFIER
      username                  = var.RDS_USERNAME
      password                  = var.RDS_PASSWORD
      final_snapshot_identifier = var.RDS_SNAPSHOT_NAME
      skip_final_snapshot       = var.RDS_SNAPSHOT_SKIP
      allocated_storage         = var.RDS_ALLOCATED_STORAGE
      storage_type              = var.RDS_STORAGE_TYPE
      instance_class            = var.RDS_INSTANCE_CLASS
      engine                    = var.RDS_ENGINE
      engine_version            = var.RDS_ENGINE_VERSION
      publicly_accessible       = var.RDS_PUBLIC_ACCESS

    vpc_security_group_ids    = [aws_security_group.rds_sg.id]
    db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    subnet_ids    = [
        aws_subnet.private_subnet.id,
        aws_subnet.backup_subnet.id
    ]
}

output "rds_prod_endpoint" {
    value = aws_db_instance.rds.address
}
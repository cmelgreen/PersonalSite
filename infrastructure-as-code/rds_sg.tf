resource "aws_security_group" "rds_sg" {
    vpc_id          = aws_vpc.vpc.id

    ingress {
        from_port       = var.RDS_PORT
        to_port         = var.RDS_PORT
        protocol        = "tcp"
        security_groups = [aws_security_group.server_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
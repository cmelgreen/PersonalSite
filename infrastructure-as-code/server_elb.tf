resource "aws_elb" "server_elb" {
    security_groups    = [aws_security_group.server_sg.id]
    subnets            = [aws_subnet.public_subnet.id]

    listener {
        lb_port           = var.ELB_PORT
        lb_protocol       = var.ELB_PROTOCOL
        instance_port     = var.ELB_INSTANCE_PORT
        instance_protocol = var.ELB_INSTANCE_PROTOCOL
    }

    health_check {
        healthy_threshold   = var.HEALTH_THRESHOLD
        unhealthy_threshold = var.UNHEALTH_THRESHOLD
        timeout             = var.HEALTH_TIMEOUT
        interval            = var.HEALTH_INTERVAL
        target              = "${var.ELB_INSTANCE_PROTOCOL}:${var.ELB_INSTANCE_PORT}/"
    }
}

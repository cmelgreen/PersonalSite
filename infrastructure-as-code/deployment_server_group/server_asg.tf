resource "aws_autoscaling_group" "server_asg" {
    name                        = "server_asg"

    min_size                    = var.SERVER_ASG_MIN
    max_size                    = var.SERVER_ASG_MAX
    desired_capacity            = var.SEVER_ASG_DEFAULT

    health_check_grace_period   = var.SERVER_ASG_HEALTH_PERIOD
    health_check_type           = var.SERVER_ASG_HEALTH_TYPE
    force_delete                = var.SERVER_ASG_FORCE

    launch_configuration        = aws_launch_configuration.server_lc.name
    vpc_zone_identifier         = [aws_subnet.private_subnet.id]

    load_balancers              = [aws_elb.server_elb.name]
}
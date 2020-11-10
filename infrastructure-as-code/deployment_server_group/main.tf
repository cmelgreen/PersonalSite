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

resource "aws_launch_configuration" "server_lc" {
    name              = "server_lc_${formatdate("YYYY_MM_DD_HH_mm", timestamp())}"

    image_id          = var.SERVER_IMAGE
    instance_type     = var.SERVER_INSTANCE_TYPE
    user_data         = templatefile(var.SERVER_USER_DATA, {region = var.AWS_REGION})

    security_groups   = [aws_security_group.server_sg.id]
    iam_instance_profile = aws_iam_instance_profile.server_iam_profile.name
    key_name          = var.SERVER_KEY

    associate_public_ip_address = var.SERVER_PUBLIC_IP

    root_block_device {
        volume_type = var.SERVER_VOL_TYPE
        volume_size = var.SERVER_VOL_SIZE
    }

    lifecycle {
        create_before_destroy = true
    }
}

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

### rewrite with for_each

resource "aws_iam_role" "server_iam_role" {
    name = var.SERVER_IAM_NAME
    force_detach_policies = var.SERVER_IAM_FORCE_DETATCH

    assume_role_policy = var.SERVER_IAM_POLICY
}

resource "aws_iam_instance_profile" "server_iam_profile" {
    role = aws_iam_role.server_iam_role.name
}

resource "aws_iam_role_policy_attachment" "server_iam_full_ssm" {
    role        = aws_iam_role.server_iam_role.name
    policy_arn  = var.IAM_FULL_SSM_ARN
}

resource "aws_iam_role_policy_attachment" "server_iam_codedploy" {
    role        = aws_iam_role.server_iam_role.name
    policy_arn  = var.IAM_CD_EC2_ARN
}




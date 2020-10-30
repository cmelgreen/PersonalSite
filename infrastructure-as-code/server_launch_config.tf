resource "aws_launch_configuration" "server_lc" {
    name              = "server_lc_${formatdate("YYYY_MM_DD_HH_mm", timestamp())}"

    image_id          = var.SERVER_IMAGE
    instance_type     = var.SERVER_INSTANCE_TYPE
    user_data         = templatefile(var.SERVER_USER_DATA, {region = var.REGION})

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
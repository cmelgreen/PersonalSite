resource "aws_instance" "build_server" {
    ami                         = var.SERVER_IMAGE
    instance_type               = var.BACKEND_INSTANCE_TYPE
    associate_public_ip_address = true
    key_name                    = var.SERVER_KEY
    
    subnet_id                   = aws_subnet.public_subnet.id
    iam_instance_profile        = aws_iam_instance_profile.backend_iam_profile.name
	vpc_security_group_ids      = [aws_security_group.server_sg.id]

    user_data                   = file(var.BACKEND_USER_DATA)
}
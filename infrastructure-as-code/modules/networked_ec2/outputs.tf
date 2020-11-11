
output "public_ip" {
    value = aws_instance.build_server.public_ip
}

output "iam_role_arn" {
    value = aws_iam_role.iam_role
}
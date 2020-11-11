
output "backend_server_endpoint" {
    value = aws_instance.build_server.public_ip
}
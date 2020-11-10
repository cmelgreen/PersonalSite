output "server_elb_endpoint" {
    value = aws_elb.server_elb.dns_name
}
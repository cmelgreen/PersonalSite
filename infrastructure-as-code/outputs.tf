output "build_server_endpoint" {
    value = module.build_server.public_ip
}

output "deployment_group_endpoint" {
    value = module.deployment_server_group.elb_endpoint
}
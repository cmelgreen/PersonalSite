
# build_server
    subnet_id                   = aws_subnet.public_subnet.id
    vpc_security_group_ids      = [aws_security_group.server_sg.id]

# deployment_group 

    vpc_zone_identifier         = [aws_subnet.private_subnet.id]
    load_balancers              = [aws_elb.elb.name]

    security_groups             = [aws_security_group.sg.id]
    subnets                     = [aws_subnet.public_subnet.id]

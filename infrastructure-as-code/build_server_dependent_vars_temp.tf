# need pass to build_server_iam_policies 

    policy_arn          = var.IAM_CD_DEPLOYER_ARN
    policy_arn          = var.IAM_CD_DEPLOY_ARN
    policy_arn          = var.IAM_FULL_SSM_ARN
    policy_arn          = var.IAM_FULL_S3_ARN

# build_server

    subnet_id                   = aws_subnet.public_subnet.id
    vpc_security_group_ids      = [aws_security_group.server_sg.id]
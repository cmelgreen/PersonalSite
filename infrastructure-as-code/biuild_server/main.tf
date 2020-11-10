resource "aws_instance" "build_server" {
    ami                         = var.BUILD_SERVER_AMI
    instance_type               = var.BUILD_SERVER_INSTANCE_TYPE
    associate_public_ip_address = var.BUILD_SERVER_PUBLIC_IP
    key_name                    = var.BUILD_SERVER_KEY

    iam_instance_profile        = aws_iam_instance_profile.backend_iam_profile.name
    
    subnet_id                   = var.BUILD_SERVER_SUBNET
    vpc_security_group_ids      = var.BUILD_SERVER_VPC_SG_IDS

    # subnet_id                   = aws_subnet.public_subnet.id
	# vpc_security_group_ids      = [aws_security_group.server_sg.id]

    user_data                   = var.BUILD_SERVER_USER_DATA
}

resource "aws_iam_instance_profile" "build_server_iam_profile" {
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role" "build_server_iam_role" {
    name                = var.BUILD_SERVER_IAM_ROLE
    assume_role_policy  = var.BUILD_SERVER_IAM_POLICY
}

### Add loop for IAM attachments to iterate over ARNS

resource "aws_iam_role_policy_attachment" "build_server_iam_codedeploy_deployer" {
    policy_arn          = var.IAM_CD_DEPLOYER_ARN
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role_policy_attachment" "build_server_iam_codedeploy" {
    policy_arn          = var.IAM_CD_DEPLOY_ARN
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role_policy_attachment" "build_server_iam_full_ssm" {
    policy_arn          = var.IAM_FULL_SSM_ARN
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role_policy_attachment" "build_server_iam_s3" {
    for_each
    policy_arn          = var.IAM_FULL_S3_ARN
    role                = aws_iam_role.build_server_iam_role.name
}

### Make adding github webhook conditional AND iterable over list of repos

resource "github_repository_webhook" "github_webhook" {
    count = var.
    repository = var.GITHUB_REPO

    configuration {
        url          = "http://${aws_instance.build_server.public_ip}/github-webhook/"
        content_type = var.GITHUB_CONTENT_TYPE
        insecure_ssl = var.GITHUB_INSECURE_SSL
    }

    events = var.GITHUB_EVENTS
}
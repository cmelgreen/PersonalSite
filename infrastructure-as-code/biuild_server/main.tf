resource "aws_instance" "build_server" {
    ami                         = var.SERVER_IMAGE
    instance_type               = var.BUILD_SERVER_INSTANCE_TYPE
    associate_public_ip_address = var.BUILD_SERVER_PUBLIC_IP
    key_name                    = var.BUILD_SERVER_KEY
    
    subnet_id                   = aws_subnet.public_subnet.id
    iam_instance_profile        = aws_iam_instance_profile.backend_iam_profile.name
	vpc_security_group_ids      = [aws_security_group.server_sg.id]

    user_data                   = var.BUILD_SERVER_USER_DATA
}

resource "aws_iam_instance_profile" "build_server_iam_profile" {
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role" "build_server_iam_role" {
    name                = var.BUILD_SERVER_IAM_ROLE
    assume_role_policy  = var.BUILD_SERVER_IAM_POLICY
}

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
    policy_arn          = var.IAM_FULL_S3_ARN
    role                = aws_iam_role.build_server_iam_role.name
}

provider "github" {
	token = file(var.GITHUB_TOKEN)
	owner = var.GITHUB_OWNER
}

resource "github_repository_webhook" "personal_site_webhook" {
  repository = var.GITHUB_REPO

  configuration {
    url          = "http://${aws_instance.build_server.public_ip}/github-webhook/"
    content_type = var.GITHUB_CONTENT_TYPE
    insecure_ssl = var.GITHUB_INSECURE_SSL
  }

  events = var.GITHUB_EVENTS
}
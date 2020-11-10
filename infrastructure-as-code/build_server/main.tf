resource "aws_instance" "build_server" {
    ami                         = var.BUILD_SERVER_AMI
    instance_type               = var.BUILD_SERVER_INSTANCE_TYPE
    associate_public_ip_address = var.BUILD_SERVER_PUBLIC_IP
    key_name                    = var.BUILD_SERVER_KEY

    iam_instance_profile        = aws_iam_instance_profile.build_server_iam_profile.name
    
    subnet_id                   = var.BUILD_SERVER_SUBNET
    vpc_security_group_ids      = var.BUILD_SERVER_VPC_SG_IDS

    user_data                   = var.BUILD_SERVER_USER_DATA
}

resource "aws_iam_instance_profile" "build_server_iam_profile" {
    role                = aws_iam_role.build_server_iam_role.name
}

resource "aws_iam_role" "build_server_iam_role" {
    name                = var.BUILD_SERVER_IAM_ROLE
    assume_role_policy  = var.BUILD_SERVER_IAM_POLICY
}

resource "aws_iam_role_policy_attachment" "build_server_iam_policy_attachments" {
    for_each            = toset(var.BUILD_SERVER_IAM_POLICIES)

    policy_arn          = each.value
    role                = aws_iam_role.build_server_iam_role.name
}

### Make adding github webhook conditional AND iterable over list of repos

resource "github_repository_webhook" "github_webhook" {
    count = var.GITHUB_CREATE_WEBHOOK ? 1 : 0
    repository = var.GITHUB_REPO

    configuration {
        url          = "http://${aws_instance.build_server.public_ip}/github-webhook/"
        content_type = var.GITHUB_CONTENT_TYPE
        insecure_ssl = var.GITHUB_INSECURE_SSL
    }

    events = var.GITHUB_EVENTS
}
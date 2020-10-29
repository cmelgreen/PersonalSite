resource "aws_iam_role" "server_iam_role" {
    name = var.SERVER_IAM_NAME
    force_detach_policies = var.SERVER_IAM_FORCE_DETATCH

    assume_role_policy = var.SERVER_IAM_POLICY
}

resource "aws_iam_instance_profile" "server_iam_profile" {
    role = aws_iam_role.server_iam_role.name
}

resource "aws_iam_role_policy_attachment" "server_iam_full_ssm" {
    role        = aws_iam_role.server_iam_role.name
    policy_arn  = var.IAM_FULL_SSM_ARN
}

resource "aws_iam_role_policy_attachment" "server_iam_codedploy" {
    role        = aws_iam_role.server_iam_role.name
    policy_arn  = var.IAM_CODEDEPLOY_ARN
}
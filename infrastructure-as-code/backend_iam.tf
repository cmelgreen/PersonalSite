resource "aws_iam_instance_profile" "backend_iam_profile" {
    role                = aws_iam_role.backed_iam_role.name
}

resource "aws_iam_role" "backed_iam_role" {
    name                = var.BACKEND_IAM_NAME
    assume_role_policy  = var.BACKEND_IAM_POLICY
}

resource "aws_iam_role_policy_attachment" "backend_iam_codedeploy_deployer" {
    policy_arn          = var.IAM_CD_DEPLOYER_ARN
    role                = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "backend_iam_codedeploy" {
    policy_arn          = var.IAM_CD_DEPLOY_ARN
    role                = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "backend_iam_full_ssm" {
    policy_arn          = var.IAM_FULL_SSM_ARN
    role                = aws_iam_role.server_cd_iam_role.name
}

resource "aws_iam_role_policy_attachment" "backend_iam_s3" {
    policy_arn          = var.IAM_FULL_S3_ARN
    role                = aws_iam_role.server_cd_iam_role.name
}


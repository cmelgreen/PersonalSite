resource "aws_codedeploy_app" "server_app" {
    name                    = var.APP_NAME
}

resource "aws_s3_bucket" "server_app_bucket" {
    bucket                  = var.APP_BUCKET
}

resource "aws_codedeploy_deployment_group" "server_app_group" {
    deployment_group_name   = var.APP_GROUP
    app_name                = aws_codedeploy_app.server_app.name

    service_role_arn        = aws_iam_role.backend_iam_role.arn
    autoscaling_groups      = [aws_autoscaling_group.server_asg.name]

    auto_rollback_configuration {
        enabled             = var.APP_ROLLBACK
        events              = var.APP_ROLLBACK_EVENTS
    }
}
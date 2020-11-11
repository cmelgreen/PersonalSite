resource "aws_codedeploy_app" "app" {
    name                    = var.NAME
}

resource "aws_s3_bucket" "bucket" {
    bucket                  = var.BUCKET
}

resource "aws_codedeploy_deployment_group" "group" {
    deployment_group_name   = var.GROUP_NAME
    app_name                    = "${aws_codedeploy_app.app.name}-group"

    service_role_arn        = var.SERVICE_ROLE
    autoscaling_groups      = var.ASG

    auto_rollback_configuration {
        enabled             = var.ROLLBACK
        events              = var.ROLLBACK_EVENTS
    }
}
resource "github_repository_webhook" "github_webhook" {
    repository = var.REPO

    configuration {
        url          = "http://${var.TARGET_}/github-webhook/"
        content_type = var.CONTENT_TYPE
        insecure_ssl = var.INSECURE_SSL
    }

    events = var.EVENTS
}
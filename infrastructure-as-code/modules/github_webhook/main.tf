resource "github_repository_webhook" "github_webhook" {
    repository = var.REPO

    configuration {
        url          = "http://${var.TARGET_IP}/github-webhook/"
        content_type = var.CONTENT_TYPE
        insecure_ssl = var.INSECURE_SSL
    }

    events = var.EVENTS
}
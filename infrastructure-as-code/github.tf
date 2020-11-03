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
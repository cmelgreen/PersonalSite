provider "aws" {
    region = var.AWS_REGION
}

provider "github" {
	token = file(var.GITHUB_TOKEN)
	owner = var.GITHUB_OWNER
}
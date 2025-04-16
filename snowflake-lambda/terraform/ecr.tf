# Stage 1: Just creates ECR repo
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "lambda_repo" {
  name                 = "snowflake-lambda"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.lambda_repo.repository_url
}
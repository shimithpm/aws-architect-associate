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
  force_delete         = true  # Allows easy cleanup

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "snowflake-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "snowflake_lambda" {
  function_name = "snowflake-connector"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.lambda_repo.repository_url}:latest"

  timeout      = 30
  memory_size  = 512

  environment {
    variables = {
      SNOWFLAKE_USER      = var.snowflake_user
      SNOWFLAKE_PASSWORD  = var.snowflake_password
      SNOWFLAKE_ACCOUNT   = var.snowflake_account
      SNOWFLAKE_WAREHOUSE = var.snowflake_warehouse
      SNOWFLAKE_DATABASE  = var.snowflake_database
      SNOWFLAKE_SCHEMA    = var.snowflake_schema
    }
  }

  depends_on = [
    aws_ecr_repository.lambda_repo
  ]
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.snowflake_lambda.function_name}"
  retention_in_days = 7
}
# Stage 2: Creates Lambda and other resources
variable "docker_image_uri" {
  description = "Full URI of the pushed Docker image (from CI/CD)"
  type        = string
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

resource "aws_lambda_function" "snowflake_lambda" {
  function_name = "snowflake-connector"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
  image_uri     = var.docker_image_uri # From CI/CD
  timeout       = 30
  memory_size   = 512
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
}
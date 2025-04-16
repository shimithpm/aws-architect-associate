output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = aws_lambda_function.snowflake_lambda.function_name
}


output "lambda_role_arn" {
  description = "ARN of the IAM role used by Lambda"
  value       = aws_iam_role.lambda_exec.arn
}
docker build -t 385188446914.dkr.ecr.us-east-1.amazonaws.com/snowflake-lambda .
docker push ${{ env.REPO_URL }}:$GITHUB_SHA
echo "IMAGE_URI=385188446914.dkr.ecr.us-east-1.amazonaws.com/snowflake-lambda
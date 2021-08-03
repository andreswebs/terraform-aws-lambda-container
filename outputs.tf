output "repository_url" {
  value = aws_ecr_repository.this.repository_url
  description = "ECR repository URL"
}

output "image_hash" {
  value = local.hash
  description = "Hash of the lambda source code, applied as a tag to the container image"
}

output "ecr_repository" {
  value = aws_ecr_repository.this
  description = "The AWS ECR Repository resource"
}

output "lambda_function" {
  value = aws_lambda_function.this
  description = "The AWS Lambda resource"
}

output "lambda_exec_role" {
  value = aws_iam_role.lambda_exec
  description = "The AWS Lambda IAM Role resource"
}

output "local_id" {
  value = local.current_id
  description = "Identifier string used as a suffix to name generated resources"
}

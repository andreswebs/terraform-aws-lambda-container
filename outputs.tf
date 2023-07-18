output "function" {
  value       = var.create_lambda ? aws_lambda_function.this[0] : null
  description = "The AWS Lambda resource"
}

output "role" {
  value       = aws_iam_role.lambda_exec
  description = "The AWS Lambda IAM Role resource"
}

output "local_id" {
  value       = local.current_id
  description = "Identifier string used as a suffix to name generated resources"
}

output "image_uri" {
  value       = var.lambda_image_uri
  description = "Lambda image URI"
}

output "log_group" {
  value = aws_cloudwatch_log_group.this
  description = "The AWS CloudWatch log group resource"
}

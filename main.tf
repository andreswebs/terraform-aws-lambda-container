/**
* Creates a Lambda function from an appropriate container image (from AWS ECR), with an associated Log Group and IAM Role.
*
* Other supporting resources, such as event sources for the Lambda function, must be integrated separately with the Lambda function through the module outputs.
*/

terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.46.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }

  }
}

data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "random_id" "id" {
  byte_length = 8
}

locals {
  lambda_name_prefix   = var.lambda_name_prefix != null && var.lambda_name_prefix != "" ? var.lambda_name_prefix : "function"
  current_id           = var.local_id != null && var.local_id != "" ? var.local_id : random_id.id.hex
  lambda_name          = var.use_id ? "${local.lambda_name_prefix}-${local.current_id}" : local.lambda_name_prefix
  log_group_name       = "/aws/lambda/${local.lambda_name}"
  log_group_arn        = "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group_name}"
  has_filesystem       = var.efs_access_point_arn != null && var.efs_access_point_arn != "" && var.efs_local_mount_path != null && var.efs_local_mount_path != ""
  efs_local_mount_path = var.efs_local_mount_path == "" ? null : var.efs_local_mount_path
  create_image         = var.lambda_image_uri == "" || var.lambda_image_uri == null
}

module "ecr_image" {
  count                = local.create_image ? 1 : 0
  source               = "andreswebs/ecr-image/aws"
  version              = "1.1.0"
  ecr_namespace        = var.ecr_namespace
  image_suffix         = var.image_suffix
  image_default_tag    = var.image_default_tag
  image_source_path    = var.lambda_source_path
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = var.scan_on_push
  lifecycle_policy     = var.lifecycle_policy
  hash_script          = var.hash_script
  push_script          = var.push_script
}

resource "aws_cloudwatch_log_group" "this" {
  name              = local.log_group_name
  retention_in_days = var.lambda_log_retention_in_days
}

data "aws_iam_policy_document" "lambda_exec" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_permissions" {

  statement {
    sid = "logs"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${local.log_group_arn}",
      "${local.log_group_arn}:*",
      "${local.log_group_arn}:*:*"
    ]
  }

}

resource "aws_iam_role" "lambda_exec" {
  name                  = local.lambda_name
  assume_role_policy    = data.aws_iam_policy_document.lambda_exec.json
  force_detach_policies = true
}

resource "aws_iam_role_policy" "lambda_permissions" {
  name   = "lambda-permissions"
  role   = aws_iam_role.lambda_exec.id
  policy = data.aws_iam_policy_document.lambda_permissions.json
}

resource "aws_iam_role_policy" "kms_permissions" {
  count = var.use_kms_key ? 1 : 0
  name  = "kms-permissions"
  role  = aws_iam_role.lambda_exec.id

  policy = templatefile("${path.module}/tpl/kms-permissions-policy.json.tpl", {
    kms_key_arn = var.lambda_kms_key_arn
  })

}

resource "aws_iam_role_policy_attachment" "xray_permissions" {
  count = var.enable_xray ? 1 : 0
  role = aws_iam_role.lambda_exec.id
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.lambda_role_managed_policies)
  role       = aws_iam_role.lambda_exec.name
  policy_arn = each.value
}

locals {
  lambda_image_uri = local.create_image ? module.ecr_image[0].image_uri : var.lambda_image_uri
}

resource "aws_lambda_function" "this" {
  function_name = local.lambda_name
  role          = aws_iam_role.lambda_exec.arn
  description   = var.lambda_description
  package_type  = "Image"
  image_uri     = local.lambda_image_uri
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  kms_key_arn   = var.lambda_kms_key_arn

  reserved_concurrent_executions = var.lambda_reserved_concurrency

  dynamic "file_system_config" {
    for_each = local.has_filesystem ? [1] : []
    content {
      arn              = var.efs_access_point_arn
      local_mount_path = local.efs_local_mount_path
    }
  }

  dynamic "tracing_config" {
    for_each = var.enable_xray ? [1] : []
    content {
      mode = "Active"
    }
  }

  vpc_config {
    security_group_ids = var.lambda_security_group_ids
    subnet_ids         = var.lambda_subnet_ids
  }

  depends_on = [
    aws_cloudwatch_log_group.this,
    aws_iam_role_policy_attachment.this
  ]

  environment {
    variables = var.lambda_env_vars
  }

}

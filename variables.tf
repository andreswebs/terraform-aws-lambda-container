variable "use_id" {
  type        = bool
  description = "Use an identifier string as a suffix when naming resources?"
  default     = true
}

variable "local_id" {
  type        = string
  description = "(Optional) An identifier string to be appended to resource names. A random string will be generated if this is not provided and use_id is set to true"
  default     = null
}

variable "lambda_image_uri" {
  type        = string
  description = "Image URI for the Lambda function"
}

variable "lambda_log_retention_in_days" {
  type        = number
  description = "Lambda log retention period in days"
  default     = 14
}

variable "lambda_name_prefix" {
  type        = string
  description = "A prefix for the Lambda name, will be prepended to a random ID if `use_id` is set to true"
  default     = "function"
}

variable "lambda_description" {
  type        = string
  description = "(Optional) Description of the Lambda function"
  default     = ""
}

variable "lambda_memory_size" {
  type        = number
  description = "Amount of memory in MB assigned to the Lambda function"
  default     = 128
}

variable "lambda_timeout" {
  type        = number
  description = "Amount of time the Lambda Function has to run in seconds"
  default     = 3
}

variable "lambda_reserved_concurrency" {
  type        = number
  description = "Amount of reserved concurrent executions for the lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations"
  default     = -1
}

variable "lambda_env_vars" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
  default     = null
}

variable "lambda_role_managed_policies" {
  type        = list(string)
  description = "IAM managed policies to attach to the Lambda execution role"
  default     = []
}

variable "lambda_subnet_ids" {
  type        = list(string)
  description = "(Optional) List of subnets to use"
  default     = []
}

variable "lambda_security_group_ids" {
  type        = list(string)
  description = "(Optional) List of security groups to use"
  default     = []
}

variable "lambda_kms_key_arn" {
  type        = string
  description = "(Optional) ARN of an AWS KMS key used to encrypt environment variables"
  default     = null
}

variable "use_kms_key" {
  type        = bool
  description = "Use a KMS key to encrypt Lambda environment variables?"
  default     = false
}

variable "efs_access_point_arn" {
  type        = string
  description = "(Optional) ARN of EFS access point"
  default     = null
}

variable "efs_local_mount_path" {
  type        = string
  description = "(Optional) Local mount path of the EFS filesystem. Must start with `/mnt/`"
  default     = ""

  validation {
    condition     = var.efs_local_mount_path == "" || (length(var.efs_local_mount_path) >= 5 && substr(var.efs_local_mount_path, 0, 5) == "/mnt/")
    error_message = "Must start with `/mnt/` ."
  }

}

variable "enable_xray" {
  type        = bool
  description = "(Optional) Enable AWS X-Ray tracing?"
  default     = true
}

variable "enable_lambda_insights" {
  type        = bool
  description = "(Optional) Enable AWS CloudWatch Lambda Insights?"
  default     = true
}

variable "create_lambda" {
  type        = bool
  description = "Create the lambda function?"
  default     = true
}

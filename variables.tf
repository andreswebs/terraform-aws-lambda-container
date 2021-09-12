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
  default     = ""
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
  default     = {}
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


variable "ecr_namespace" {
  type        = string
  description = "(Optional) A namespace prefixed to the ECR repository name, e.g. 'my-namespace' in my-namespace/my-repo"
  default     = null
}

variable "image_suffix" {
  type        = string
  description = "(Optional) Suffix used to name the container image, e.g. 'my-repo' in my-namespace/my-repo"
  default     = null
}

variable "image_default_tag" {
  type        = string
  description = "(Optional) Default tag to use for the container image"
  default     = "latest"
}

variable "image_tag_mutability" {
  type        = string
  description = "(Optional) Image tag immutability. Must be one of MUTABLE or IMMUTABLE"
  default     = "MUTABLE"

  validation {
    condition     = can(regex("^MUTABLE|IMMUTABLE$", var.image_tag_mutability))
    error_message = "Must be one of MUTABLE or IMMUTABLE."
  }

}

variable "scan_on_push" {
  type        = bool
  description = "Scan image on push?"
  default     = true
}

variable "lifecycle_policy" {
  type        = string
  description = "(Optional) Repository lifecycle policy. A default will be used if not provided"
  default     = null
}

variable "hash_script" {
  type        = string
  description = "(Optional) Path to a custom script to generate a hash of source contents"
  default     = ""
}

variable "push_script" {
  type        = string
  description = "(Optional) Path to a custom script to build and push the container image"
  default     = ""
}

variable "lambda_source_path" {
  type        = string
  description = "(Optional) Path to the Lambda source code"
  default     = null
}

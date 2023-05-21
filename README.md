# terraform-aws-lambda-container

Creates a Lambda function from an appropriate container image (from AWS ECR), with an associated Log Group and IAM Role.

Other supporting resources, such as event sources for the Lambda function, must be integrated separately with the Lambda function through the module outputs.

[//]: # (BEGIN_TF_DOCS)


## Usage

Example:

```hcl
module "example" {
  source             = "github.com/andreswebs/terraform-aws-lambda-container"
  lambda_image_uri   = var.lambda_image_uri
  lambda_name_prefix = "example-lambda"
  lambda_description = "Does things"

  ## adjust as needed
  lambda_memory_size          = 2048 ## --> default 128
  lambda_timeout              = 600  ## --> default 3
  lambda_reserved_concurrency = 1    ## --> default -1

  lambda_role_managed_policies = [
    var.policy_arn_my_lambda_permissions
  ]

  lambda_env_vars = {
    EXAMPLE_VAR = "ok"
  }

}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_efs_access_point_arn"></a> [efs\_access\_point\_arn](#input\_efs\_access\_point\_arn) | (Optional) ARN of EFS access point | `string` | `null` | no |
| <a name="input_efs_local_mount_path"></a> [efs\_local\_mount\_path](#input\_efs\_local\_mount\_path) | (Optional) Local mount path of the EFS filesystem. Must start with `/mnt/` | `string` | `""` | no |
| <a name="input_enable_xray"></a> [enable\_xray](#input\_enable\_xray) | (Optional) Enable AWS X-Ray tracing? | `bool` | `true` | no |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | (Optional) Description of the Lambda function | `string` | `""` | no |
| <a name="input_lambda_env_vars"></a> [lambda\_env\_vars](#input\_lambda\_env\_vars) | Environment variables for the Lambda function | `map(string)` | `null` | no |
| <a name="input_lambda_image_uri"></a> [lambda\_image\_uri](#input\_lambda\_image\_uri) | Image URI for the Lambda function | `string` | n/a | yes |
| <a name="input_lambda_kms_key_arn"></a> [lambda\_kms\_key\_arn](#input\_lambda\_kms\_key\_arn) | (Optional) ARN of an AWS KMS key used to encrypt environment variables | `string` | `null` | no |
| <a name="input_lambda_log_retention_in_days"></a> [lambda\_log\_retention\_in\_days](#input\_lambda\_log\_retention\_in\_days) | Lambda log retention period in days | `number` | `14` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | Amount of memory in MB assigned to the Lambda function | `number` | `128` | no |
| <a name="input_lambda_name_prefix"></a> [lambda\_name\_prefix](#input\_lambda\_name\_prefix) | A prefix for the Lambda name, will be prepended to a random ID if `use_id` is set to true | `string` | `"function"` | no |
| <a name="input_lambda_reserved_concurrency"></a> [lambda\_reserved\_concurrency](#input\_lambda\_reserved\_concurrency) | Amount of reserved concurrent executions for the lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations | `number` | `-1` | no |
| <a name="input_lambda_role_managed_policies"></a> [lambda\_role\_managed\_policies](#input\_lambda\_role\_managed\_policies) | IAM managed policies to attach to the Lambda execution role | `list(string)` | `[]` | no |
| <a name="input_lambda_security_group_ids"></a> [lambda\_security\_group\_ids](#input\_lambda\_security\_group\_ids) | (Optional) List of security groups to use | `list(string)` | `[]` | no |
| <a name="input_lambda_subnet_ids"></a> [lambda\_subnet\_ids](#input\_lambda\_subnet\_ids) | (Optional) List of subnets to use | `list(string)` | `[]` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | Amount of time the Lambda Function has to run in seconds | `number` | `3` | no |
| <a name="input_local_id"></a> [local\_id](#input\_local\_id) | (Optional) An identifier string to be appended to resource names. A random string will be generated if this is not provided and use\_id is set to true | `string` | `null` | no |
| <a name="input_use_id"></a> [use\_id](#input\_use\_id) | Use an identifier string as a suffix when naming resources? | `bool` | `true` | no |
| <a name="input_use_kms_key"></a> [use\_kms\_key](#input\_use\_kms\_key) | Use a KMS key to encrypt Lambda environment variables? | `bool` | `false` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_uri"></a> [image\_uri](#output\_image\_uri) | Lambda image URI |
| <a name="output_lambda_exec_role"></a> [lambda\_exec\_role](#output\_lambda\_exec\_role) | The AWS Lambda IAM Role resource |
| <a name="output_lambda_function"></a> [lambda\_function](#output\_lambda\_function) | The AWS Lambda resource |
| <a name="output_local_id"></a> [local\_id](#output\_local\_id) | Identifier string used as a suffix to name generated resources |
| <a name="output_log_group"></a> [log\_group](#output\_log\_group) | The AWS CloudWatch log group resource |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.50 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.5 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.50 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.kms_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.xray_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

[//]: # (END_TF_DOCS)


## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).

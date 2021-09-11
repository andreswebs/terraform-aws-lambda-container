# terraform-aws-lambda-container

## Pre-requisites

The `bash` shell must be present on the machine, as well as the following utilities: `find`, `sort`, `xargs`, `md5sum`.

Other dependencies are:

- Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Install [Docker](https://docs.docker.com/engine/install/)

[//]: # (BEGIN_TF_DOCS)

Creates an ECR repository, pushes a container image for AWS Lambda, and creates a Lambda function from the image, with an associated Log Group and IAM Role.

Other supporting resources, such as event sources for the Lambda function, must be integrated separately with the Lambda function through the module outputs.

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
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | (Optional) Description of the Lambda function | `string` | `""` | no |
| <a name="input_lambda_env_vars"></a> [lambda\_env\_vars](#input\_lambda\_env\_vars) | Environment variables for the Lambda function | `map(string)` | `{}` | no |
| <a name="input_lambda_image_uri"></a> [lambda\_image\_uri](#input\_lambda\_image\_uri) | Image URI for the Lambda function | `string` | n/a | yes |
| <a name="input_lambda_kms_key_arn"></a> [lambda\_kms\_key\_arn](#input\_lambda\_kms\_key\_arn) | (Optional) ARN of an AWS KMS key used to encrypt environment variables | `string` | `null` | no |
| <a name="input_lambda_log_retention_in_days"></a> [lambda\_log\_retention\_in\_days](#input\_lambda\_log\_retention\_in\_days) | n/a | `number` | `14` | no |
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr_image"></a> [ecr\_image](#module\_ecr\_image) |  | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repository"></a> [ecr\_repository](#output\_ecr\_repository) | The AWS ECR Repository resource |
| <a name="output_image_hash"></a> [image\_hash](#output\_image\_hash) | Hash of the lambda source code, applied as a tag to the container image |
| <a name="output_lambda_exec_role"></a> [lambda\_exec\_role](#output\_lambda\_exec\_role) | The AWS Lambda IAM Role resource |
| <a name="output_lambda_function"></a> [lambda\_function](#output\_lambda\_function) | The AWS Lambda resource |
| <a name="output_local_id"></a> [local\_id](#output\_local\_id) | Identifier string used as a suffix to name generated resources |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | ECR repository URL |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.46.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.46.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.kms_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

[//]: # (END_TF_DOCS)


## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgements

The code for pushing images to ECR (under `scripts/`) was based on:

<https://github.com/mathspace/terraform-aws-ecr-docker-image>

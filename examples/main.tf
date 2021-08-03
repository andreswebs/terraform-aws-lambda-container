module "example" {
  source             = "github.com/andreswebs/terraform-aws-lambda-container"
  ecr_namespace      = "my-images"
  image_suffix       = "example-lambda" ## --> this will create my-images/example-lambda in ECR
  lambda_source_path = "path/to/your/lambda/code" ## --> must have a Dockerfile
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
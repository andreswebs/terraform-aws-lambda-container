# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2023-05-21

### Changed
- Remove optional image creation; `lambda_image_uri` is now required

## [2.3.0] - 2021-09-17

### Added
- Enable X-Ray tracing by default

## [2.2.1] - 2021-09-17

### Changed
- Fix lambda_env_vars: default to `null`

## [2.2.0] - 2021-09-17

### Added
- Output the aws_cloudwatch_log_group

## [2.1.0] - 2021-09-17

### Changed
- Use [andreswebs/ecr-image/aws](https://registry.terraform.io/modules/andreswebs/ecr-image/aws/latest) version 1.1.0

## [2.0.0] - 2021-09-12

### Added
- Optional variable `lambda_image_uri`
- Conditional dependency on [andreswebs/ecr-image/aws](https://registry.terraform.io/modules/andreswebs/ecr-image/aws/latest)

### Removed
- ECR registry creation
- Scripts for pushing the image to ECR
- ECR lifecycle policy

## [1.0.0] - 2021-08-03

### Added
- Initial module configuration

[3.0.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/2.3.0...3.0.0

[2.3.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/2.2.1...2.3.0

[2.2.1]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/2.2.0...2.2.1

[2.2.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/2.1.0...2.2.0

[2.1.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/1.0.0...2.1.0

[2.0.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/1.0.0...2.0.0

[1.0.0]: "#"

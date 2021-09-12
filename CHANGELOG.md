# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2021-09-12

### Added
- Optional variable `lambda_image_uri`
- Conditional dependency on [andreswebs/ecr-image/aws](https://registry.terraform.io/modules/andreswebs/ecr-image/aws/latest)

### Changed
- 

### Removed
- ECR registry creation
- Scripts for pushing the image to ECR
- ECR lifecycle policy

## [1.0.0] - 2021-08-03

### Added
- Initial module configuration

[2.0.0]: https://github.com/andreswebs/terraform-aws-lambda-container/compare/1.0.0...2.0.0
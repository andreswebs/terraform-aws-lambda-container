# terraform-aws-lambda-container

## Pre-requisites

The `bash` shell must be present on the machine, as well as the following utilities: `find`, `sort`, `xargs`, `md5sum`.

Other dependencies are:

- Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Install [Docker](https://docs.docker.com/engine/install/)

[//]: # (END_TF_DOCS)

[//]: # (BEGIN_TF_DOCS)


## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgements

The code for pushing images to ECR (under `scripts/`) was based on:

<https://github.com/mathspace/terraform-aws-ecr-docker-image>

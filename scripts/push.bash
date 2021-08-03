#!/usr/bin/env bash

# Builds a Docker image and pushes to an AWS ECR repository
#
# Usage:
#
# ./push.bash <source path> <repository url> [<tag 1> ... <tag n>]
# ./push.bash ../src 123456789012.dkr.ecr.us-west-1.amazonaws.com/optional-namespace/hello-world latest [another-tag] ... [tag-n]
#

set -e

SOURCE_PATH="${1}"
REPOSITORY_URL="${2}"

shift 2

TAGS="${*}"
TAGS="${TAGS:-latest}"

REGION="$(echo "${REPOSITORY_URL}" | cut -d. -f4)"

(cd "${SOURCE_PATH}" && docker build -t "${REPOSITORY_URL}" .)

aws ecr get-login-password --region "${REGION}" | docker login --username AWS --password-stdin "${REPOSITORY_URL}"

for t in ${TAGS}; do
  docker tag "${REPOSITORY_URL}" "${REPOSITORY_URL}:${t}"
  docker push "${REPOSITORY_URL}:${t}"
done

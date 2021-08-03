#!/usr/bin/env bash

# Calculates hash of container image source contents
#
# Usage:
#
# ./hash.bash .
#

set -e

SOURCE_PATH="${1:-.}"

# Hash source files of the container image,
# excluding node_modules, dist, and markdown content
FILE_HASHES="$(
    cd "${SOURCE_PATH}" && \
    find . -type f -not -name '*.md' -not -path './node_modules' -not -path './dist' \
    | sort \
    | xargs md5sum
)"

HASH="$(echo "${FILE_HASHES}" | md5sum | cut -d' ' -f1)"

echo '{ "hash": "'"${HASH}"'" }'

#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}"
docker build --no-cache -f Dockerfile_manylinux2014_x86_64 -t cgohlke/imagecodecs_manylinux2014_x86_64:2022.12.22 .
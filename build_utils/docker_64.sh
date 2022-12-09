#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}"
docker build -f Dockerfile -t bokota/imagecodecs_manylinux2014_64:2022.12.7 .

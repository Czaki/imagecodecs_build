#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}"
docker build -f Dockerfile_2014 -t bokota/imagecodecs_2014_64:2020.05.30 .
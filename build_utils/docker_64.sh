#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}"
docker build -f Dockerfile -t bokota/imagecodecs_64:2020.05.30 .
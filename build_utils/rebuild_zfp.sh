#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PATH="/usr/local/opt/gettext/bin:$PATH"
build_dir=${DIR}/libs_build
download_dir=${DIR}/libs_src

echo "Build zfp"
cd "${download_dir}/zfp" || exit 1
rm -rf build
mkdir -p build
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install
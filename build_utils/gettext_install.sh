#!/usr/bin/env bash
set -e
set -x
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
download_dir=${DIR}/libs_src

wget -q https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.tar.gz

mkdir -p "${download_dir}"
tar zxf  gettext-0.20.tar.gz -C "${download_dir}"

cd "${download_dir}/gettext-0.20"

sh ./configure --disable-java 
make
make install
make clean

cd "${download_dir}"

rm -r "gettext-0.20"
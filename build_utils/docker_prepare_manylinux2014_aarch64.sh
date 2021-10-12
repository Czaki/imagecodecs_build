#!/usr/bin/env bash
set -e

yum install -y epel-release
yum install -y pcre pcre-devel openssl-devel wget libtool snappy-devel gettext gettext-devel po4a nasm meson cmake3 ninja-build

# On aarch64 machine, yum pull meson==0.47.0 and project requires meson >= 0.49.0 so installing it from source code
wget https://github.com/mesonbuild/meson/releases/download/0.49.0/meson-0.49.0.tar.gz
tar -xvzf meson-0.49.0.tar.gz
cd meson-0.49.0
export PATH=/opt/python/cp38-cp38/bin/:$PATH
python setup.py install
cd ..
rm -rf meson-0.49.0 meson-0.49.0.tar.gz

cp /opt/python/cp38-cp38/bin/meson /usr/bin/meson
cp /usr/bin/cmake3 /usr/bin/cmake
cp /usr/bin/ninja-build /usr/bin/ninja

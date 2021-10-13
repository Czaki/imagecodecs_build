#!/usr/bin/env bash
set -e

yum install -y epel-release
yum install -y pcre pcre-devel openssl-devel wget libtool snappy-devel gettext gettext-devel po4a nasm meson cmake3 ninja-build

# On aarch64 machine, yum pull meson==0.47.0 and project requires meson >= 0.49.0. Installing through pip
export PATH=/opt/python/cp38-cp38/bin/:$PATH
pip install meson==0.49.0

ln -sf /opt/python/cp38-cp38/bin/meson /usr/bin/meson
ln -sf /usr/bin/cmake3 /usr/bin/cmake
ln -sf /usr/bin/ninja-build /usr/bin/ninja

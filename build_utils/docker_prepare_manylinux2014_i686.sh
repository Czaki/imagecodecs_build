#!/usr/bin/env bash
set -e

yum install -y pcre pcre-devel openssl-devel wget libtool snappy-devel gettext gettext-devel po4a nasm python3-pip

python3 -m pip install meson
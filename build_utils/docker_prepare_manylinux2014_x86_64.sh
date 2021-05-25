#!/usr/bin/env bash
set -e

yum install -y pcre pcre-devel openssl-devel wget libtool snappy-devel gettext gettext-devel po4a nasm meson cmake3

cp /usr/bin/cmake3 /usr/bin/cmake
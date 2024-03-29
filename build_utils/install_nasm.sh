#!/usr/bin/env bash

yum install -y wget openssl-devel

wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz --no-check-certificate
tar zxf  nasm-2.15.05.tar.gz
pushd nasm-2.15.05
sh configure
make
make install
make clean

popd
rm -r nasm-2.15.05
rm nasm-2.15.05.tar.gz
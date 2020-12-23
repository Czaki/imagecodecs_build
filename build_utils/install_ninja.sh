#!/usr/bin/env bash

yum install -y wget openssl-devel

wget https://codeload.github.com/ninja-build/ninja/tar.gz/v1.10.2 -O ninja-1.10.2.tar.gz
tar zxf ninja-1.10.2.tar.gz

cd ninja-1.10.2
mkdir build
cd build
cmake ..
make
make install
make clean

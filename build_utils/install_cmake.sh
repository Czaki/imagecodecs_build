#!/usr/bin/env bash

yum install -y wget openssl-devel

wget https://github.com/Kitware/CMake/releases/download/v3.16.9/cmake-3.16.9.tar.gz
tar zxf  cmake-3.16.9.tar.gz
cd cmake-3.16.9
./bootstrap && make && make install
make clean

cd ..
rm -r cmake-3.16.9
rm cmake-3.16.9.tar.gz
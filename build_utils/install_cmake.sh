#!/usr/bin/env bash

yum install -y wget openssl-devel

wget https://github.com/Kitware/CMake/releases/download/v3.16.0/cmake-3.16.0.tar.gz
tar zxvf  cmake-3.16.0.tar.gz
cd cmake-3.16.0
./bootstrap && make && make install
make clean

#!/usr/bin/env bash

# ripple环境搭建

## 源码下载
#git clone https://github.com/ripple/rippled.git

## 依赖项安装
apt install -y cmake pkg-config protobuf-compiler libprotobuf-dev libssl-dev
wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.gz
tar xvzf boost_1_64_0.tar.gz
cd boost_1_64_0
./bootstrap.sh
./b2 -j 2
export BOOST_ROOT=$PWD

## 编译源码
cmake -Dtarget=gcc.release.unity.profile ..
cmake --build .

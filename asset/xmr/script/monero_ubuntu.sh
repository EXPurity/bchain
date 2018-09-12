#!/usr/bin/env bash

# monero环境搭建

## 源码下载
git clone https://github.com/monero-project/monero.git
cd monero
git checkout v0.12.3.0

srcdir=$PWD

## 依赖项安装
sudo apt install libgtest-dev && cd /usr/src/gtest && sudo cmake . && sudo make && sudo mv libg* /usr/lib/
sudo apt install build-essential cmake pkg-config libboost-all-dev libssl-dev \
  libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev \
  libreadline6-dev libldns-dev libexpat1-dev doxygen graphviz libpcsclite-dev \
  libpgm-dev

## 编译源码
cd $srcdir
make

#!/usr/bin/env bash

# 比特币环境搭建

## 源码下载
#git clone https://github.com/bitcoin/bitcoin.git

## 依赖项安装
apt install build-essential libtool autotools-dev automake pkg-config \
  libssl1.1 libssl-dev libevent-2.1.6 libevent-dev bsdmainutils python3 \
  libboost-all-dev libdb5.3++ libdb5.3++-dev libzmq3-dev

## 编译源码
./autogen.sh && ./configure --with-incompatible-bdb --without-gui && make -j 2

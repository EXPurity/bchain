#!/usr/bin/env bash

# 比特币环境搭建

## 源码下载
#git clone https://github.com/bitcoin/bitcoin.git

## 依赖项安装
brew install automake berkeley-db4 libtool boost miniupnpc openssl pkg-config \
  protobuf python qt libevent qrencode
### If you want to build the disk image with make deploy (), you need RSVG.
####  ```
####  brew install librsvg
####  ```

## 编译源码
./autogen.sh && ./configure && make -j 2

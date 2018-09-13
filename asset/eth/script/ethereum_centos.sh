#!/usr/bin/env bash

# 以太坊环境搭建

version=1.8.15

## 依赖项安装
sudo yum install -y golang

if (( 0 != $? )); then
  echo Failed to install dependencies!
  exit 1
fi

## 源码下载
mkdir -p .ethereum && cd .ethereum
wget https://github.com/ethereum/go-ethereum/archive/v$version.tar.gz \
  && mv v$version.tar.gz go-ethereum-$version.tar.gz \
  && tar xvzf go-ethereum-$version.tar.gz

if (( 0 != $? )); then
  echo Failed to download https://github.com/ethereum/go-ethereum/archive/v$version.tar.gz
  cd .. && rm -rf .ethereum
  exit 1
fi

## 编译源码
cd go-ethereum-$version && make -j 2 all

if (( 0 != $? )); then
  echo Failed to compile source code!
  cd ../.. && rm -rf .ethereum
  exit 1
fi

mkdir -p ~/bin
cp build/bin/geth build/bin/ethkey ~/bin
cd ../.. && rm -rf .ethereum

mkdir -p ~/eth/chain
cp geth.sh runas.sh ~/eth
if test -z "$(sudo grep eth /etc/passwd)"; then
  sudo useradd -d ~/eth -G $USER -s /usr/bin/bash -U eth
fi
sudo chown -R eth:eth ~/eth
cd ~/eth
./runas.sh

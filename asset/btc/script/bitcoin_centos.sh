#!/usr/bin/env bash

# 比特币环境搭建

eth0ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')

if test "testnet" == "$1"; then
  testnet=1
  txindex=1
  rpcport=18332
else
  testnet=0
  txindex=1
  rpcport=8332
fi

rpcauth=bitcoin:82a6eedb5e1d83d75af321fefcab3e2\$f343e630bef6db1f1c9861c48bc654a462decbdb68d3550af163a70b76f246a1
rpcuser=bitcoin
rpcpwd=G3aNIjgOOp383UI5LBCRCJwe8wsFthXzUqA3yvVBd1M\=
rpcconnect=127.0.0.1

version=0.16.2

## 依赖项安装
sudo yum -y install gcc-c++ libtool make autoconf automake openssl-devel libevent-devel boost-devel libdb-devel libdb-cxx-devel python3

if (( 0 != $? )); then
  echo Failed to install dependencies!
  exit 1
fi

## 源码下载
mkdir -p .bitcoin && cd .bitcoin
wget https://codeload.github.com/bitcoin/bitcoin/tar.gz/v$version \
  && mv v$version bitcoin-$version.tar.gz && tar xvzf bitcoin-$version.tar.gz

if (( 0 != $? )); then
  echo Failed to download https://codeload.github.com/bitcoin/bitcoin/tar.gz/v$version
  cd .. && rm -rf .bitcoin
  exit 1
fi

## 编译源码
cd bitcoin-$version && ./autogen.sh \
  && ./configure --with-incompatible-bdb --without-gui --without-miniupnpc \
  && make -j 2

if (( 0 != $? )); then
  echo Failed to compile source code!
  cd ../.. && rm -rf .bitcoin
  exit 1
fi

sudo mkdir -p ~/bin
cp src/bitcoind src/bitcoin-cli src/bitcoin-tx ~/bin
cd ../../ && rm -rf .bitcoin

cat > bitcoin.conf << EOF
# 配置文件所在目录：
# Windows: %APPDATA%\\Bitcoin\\
# OSX: \$HOME/Library/Application Support/Bitcoin/
# Linux: \$HOME/.bitcoin/

# 使用测试网络
testnet=$testnet
# 指定用户名和密码
rpcauth=$rpcauth
rpcuser=$rpcuser
rpcpassword=$rpcpwd
# rpc cient connect ip
rpcconnect=$rpcconnect
# 指定监听IP，需要和rpcallowip结合使用，否则无效
rpcport=$rpcport
rpcbind=127.0.0.1
rpcbind=$eth0ip
# 指定允许的通过RPC的IP
rpcallowip=127.0.0.1
rpcallowip=$eth0ip/16
txindex=$txindex
EOF

mkdir -p ~/btc/chain
cp bitcoind.sh bitcoin.conf runas.sh ~/btc
if test -z "$(sudo grep btc /etc/passwd)"; then
  sudo useradd -d ~/btc -G $USER -s /usr/bin/bash -U btc
fi
sudo chown -R btc:btc ~/btc
cd ~/btc
./runas.sh

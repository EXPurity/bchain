#!/usr/bin/env bash

# bitcoin环境搭建

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

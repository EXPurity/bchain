#!/usr/bin/env bash

# 启用测试网络

datadir=$HOME/Public/app/bcdata/btc_chain
rpcuser=bitcoin
rpcpassword=123
rpcbind1=0.0.0.0:18332
rpcallowip1=127.0.0.1
rpcallowip2=1.0.0.1/0

## 注意：
## -rpcbind与-rpcallowip同时使用才会生效

function testnet
{
  bitcoind -testnet \
    -rpcbind=$rpcbind1 \
    -rpcbind=$rpcbind2 \
    -rpcallowip=$rpcallowip1 \
    -rpcallowip=$rpcallowip2 \
    -datadir=$datadir \
    -rpcuser=$rpcuser \
    -rpcpassword=$rpcpassword \
    -deprecatedrpc=accounts \
    -txindex \
    -daemon
}

function showhelp
{
  echo $0 \<testnet\>
}

case "$1" in
  "testnet") testnet;;
  *) showhelp; exit 1;;
esac

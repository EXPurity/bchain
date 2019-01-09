#!/usr/bin/env bash

# 启用测试网络

#datadir=$HOME/Public/app/bcdata/btc_chain
datadir=$PWD/chain
rpcuser=bitcoin
rpcpassword=123
rpcbind1=127.0.0.1:18332
rpcallowip1=127.0.0.1
#rpcallowip2=1.0.0.1/0

## 注意：
## -rpcbind与-rpcallowip同时使用才会生效

function testnet
{
  bitcoind -testnet -rpcbind=$rpcbind1 -rpcallowip=$rpcallowip1 -daemon
}

function showhelp
{
  echo $0 \<testnet\>
}

case "$1" in
  "testnet") testnet;;
  *) showhelp; exit 1;;
esac

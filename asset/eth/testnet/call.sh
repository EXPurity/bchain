#!/usr/bin/env bash

argv=$*
#host=127.0.0.1:18545
host=47.96.111.40:18545
method=$1
params=""

function makeParams
{
  cnt=0
  for arg in $argv; do
    if test $cnt -eq 0; then
      let cnt+=1
      continue
    fi
    if test $cnt -gt 1; then
      params=$params","
    fi
    if test "$arg" = "true" -o "$arg" = "false"; then
      params=$params$arg
    else
        params=$params"\"$arg\""
    fi
    let cnt+=1
  done
}

function call
{
  makeParams

  curl \
    -H "Content-Type:application/json" \
    -X POST \
    -d "{\"jsonrpc\":\"2.0\",\"method\":\"$method\",\"params\":[$params],\"id\":1}" \
    $host
}

function attach
{
  geth --datadir="$datadir" attach
}

case "$1" in
  "attach") attach;;
  *) call;;
esac

# eth_blockNumber 获取当前区块高度
# eth_getBlockByNumber <tag> <boolean>
#   获取区块信息，tag可以是'earlest'，'pending'，'latest'或者十六进制的区块号
# eth_getTransactionReceipt <txid> 获取指定交易id的明细

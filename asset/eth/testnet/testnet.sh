#!/usr/bin/env bash

# 启用测试网络

datadir=$HOME/Public/app/bcdata/eth_chain
cachedir=$datadir/geth/ethash
dagdir=$datadir/geth/ethahsh
rpcaddr=0.0.0.0
rpcport=18545
rpcapi=db,eth,shh,net,web3,personal,txpool
networkid=3 #ropsten
syncmode=fast
console=console

mkdir -p $datadir

function testnet
{
  geth \
    --testnet \
    --rpc \
    --rpcapi "$rpcapi" \
    --rpccorsdomain "*" \
    --datadir "$datadir" \
    --ethash.cachedir "$cachedir" \
    --ethash.dagdir "$dagdir" \
    --rpcaddr $rpcaddr \
    --rpcport $rpcport \
    --networkid $networkid \
    --syncmode "$syncmode" \
    $console
}

function backup
{
  if test $# -ne 1; then
    echo backup file should be specified!
    return
  fi
  geth \
    --datadir "$datadir" \
    --ethash.dagdir "$dagdir" \
    --ethash.cachedir "$cachedir" \
    export \
    $1
}

function restore
{
  if test $# -ne 1; then
    echo restore file should be specified!
    return
  fi
  geth \
    --datadir "$datadir" \
    --ethash.cachedir "$cachedir" \
    --ethash.dagdir "$dagdir" \
    import \
    $1
}

function showhelp
{
  echo $0 \<testnet\|backup\|restore\> \[file\]
}

case "$1" in
  "testnet") testnet;;
  "backup") backup $2;;
  "restore") restore $2;;
  *) showhelp; exit 1;;
esac

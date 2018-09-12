#!/usr/bin/env bash

# 启用主链网络

liteserver=litecoind

datadir=$PWD/chain
confpath=$datadir/litecoin.conf
liteoption="
  -conf=$confpath
  -datadir=$datadir
  -daemon"

mkdir -p chain
cp litecoin.conf $confpath

function mainnet
{
  $liteserver $liteoption
}

function showhelp
{
  echo $0 \<mainnet\>
}

case "$1" in
  "mainnet") mainnet;;
  *) showhelp; exit 1;;
esac


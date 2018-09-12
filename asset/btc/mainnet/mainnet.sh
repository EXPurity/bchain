#!/usr/bin/env bash

# 启用主链网络

bitserver=bitcoind

datadir=$PWD/chain
confpath=$datadir/bitcoin.conf
bitoption="
  -conf=$confpath
  -datadir=$datadir
  -daemon"

mkdir -p chain
cp bitcoin.conf $confpath

function mainnet
{
  $bitserver $bitoption
}

function showhelp
{
  echo $0 \<mainnet\>
}

case "$1" in
  "mainnet") mainnet;;
  *) showhelp; exit 1;;
esac


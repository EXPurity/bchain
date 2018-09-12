#!/usr/bin/env bash

function start_bitcoind
{
  mkdir -p $PWD/chain
  bitcoind -conf=$PWD/bitcoin.conf -datadir=$PWD/chain -daemon
}

function stop_bitcoind
{
  bitcoin-cli -conf=$PWD/bitcoin.conf -datadir=$PWD/chain stop
}

function showhelp
{
  echo $0 \<start\|stop\>
}

case "$1" in
  "start") start_bitcoind;;
  "stop") stop_bitcoind;;
  *) showhelp; exit 1;;
esac

#!/usr/bin/env bash

function start_litecoind
{
  litecoind -conf=$PWD/litecoin.conf -datadir=$PWD/chain -daemon
}

function stop_litecoind
{
  litecoin-cli -conf=$PWD/litecoin.conf -datadir=$PWD/chain stop
}

function showhelp
{
  echo $0 \<start\|stop\>
}

case "$1" in
  "start") start_litecoind;;
  "stop") stop_litecoind;;
  *) showhelp; exit 1;;
esac

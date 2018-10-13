#!/usr/bin/env bash

function geth_start
{
  nohup ./geth.sh >/dev/null 2>&1 &
}

function geth_stop
{
  pid=$(ps aux | grep 'geth ' | sed '/grep/d' | awk '{print $2}')
  if test "" != "$pid"; then
    sudo kill -SIGINT $pid
  fi
}

function showhelp
{
  echo $0 \<start\|stop\>
}

case "$1" in
  "start") geth_start;;
  "stop") geth_stop;;
  *) showhelp; exit 1;;
esac

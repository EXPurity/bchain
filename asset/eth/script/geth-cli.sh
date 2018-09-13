#!/usr/bin/env bash

argv=$*
config=$PWD/ethereum.toml
datadir=$(grep 'DataDir = ' $config | sed 's/DataDir = //')
host=$(grep 'HTTPHost = ' $config | sed 's/HTTPHost = //' | sed 's/"//g')
port=$(grep 'HTTPPort = ' $config | sed 's/HTTPPort = //')
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
    http://$host:$port
}

function attach
{
  geth --datadir "$datadir" attach
}

case "$1" in
  "attach") attach;;
  *) call;;
esac

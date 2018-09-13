#!/usr/bin/env bash

argv=$*
config=$PWD/ethereum.toml
host=127.0.0.1:18545
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
  geth --config "$config" attach
}

case "$1" in
  "attach") attach;;
  *) call;;
esac

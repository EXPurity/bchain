#!/usr/bin/env bash

testnet=1
app=monerod
bindip=0.0.0.0
datadir=$PWD/chain
detach=--detach

if (( 1 == $testnet )); then
  bindport=28081
  testnet=--testnet
else
  bindport=18081
  testnet=
fi

function start_node
{
  $app $testnet \
    --rpc-bind-ip=$bindip \
    --confirm-external-bind \
    --rpc-bind-port=$bindport \
    --data-dir=$datadir \
    $detach
}

function stop_node
{
  curl -X POST \
  http://localhost:$bindport/stop_daemon \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 542e5edb-3bb3-4bf5-be6e-744b63f01bbc' \
  -H 'cache-control: no-cache'
}

function showhelp
{
  echo $0 \<start\|stop\>
}

case "$1" in
  "start") start_node;;
  "stop") stop_node;;
  *) showhelp; exit 1;;
esac

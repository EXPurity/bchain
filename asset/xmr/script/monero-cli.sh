#!/usr/bin/env bash

testnet=1

if (( 1 == $testnet )); then
  rpcport=28081
else
  rpcport=18081
fi

function client_call
{
  method=$1
  params=$2
  curl -X POST \
  http://localhost:$rpcport/json_rpc \
  -H "Content-Type: application/json" \
  -H "Postman-Token: 32718667-12c6-42f9-8202-e5392ef37fe0" \
  -H "cache-control: no-cache" \
  -d "{\"jsonrpc\":\"2.0\",\"id\":\"0\",\"method\":\"$method\",\"params\":$params}"
}

client_call "$1" "$2"

#!/usr/bin/env bash

testnet=1

if (( 1 == $testnet )); then
  rpcport=28083
else
  rpcport=18083
fi

function client_call
{
  method=$1
  params=$2
  curl -X POST \
  http://localhost:$rpcport/json_rpc \
  -H "Content-Type: application/json" \
  -H "Postman-Token: c4069867-b0e7-4ff3-a3ca-296a698ea95c" \
  -H "cache-control: no-cache" \
  -d "{\"jsonrpc\":\"2.0\",\"id\":\"0\",\"method\":\"$method\",\"params\":$params}"
}

client_call "$1" "$2"

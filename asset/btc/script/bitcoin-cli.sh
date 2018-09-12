#!/usr/bin/env bash

#curl -X POST http://bitcoin:G3aNIjgOOp383UI5LBCRCJwe8wsFthXzUqA3yvVBd1M=@172.31.32.10:18332 -d '{"jsonrpc":"1.0","method":"getbalance", "params":[],"id":1}' -H 'Content-Type:application/json'

conf=$PWD/bitcoin.conf
datadir=$PWD/chain

function client_call
{
  bitcoin-cli -conf=$conf -datadir=$datadir $*
}

client_call $*

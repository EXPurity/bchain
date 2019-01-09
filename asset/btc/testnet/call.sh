#!/usr/bin/env bash

argv=$*
rpcconnect=127.0.0.1
rpcport=18332
rpcuser=bitcoin
rpcpassword=123

function call
{
  bitcoin-cli  -testnet -rpcconnect=$rpcconnect -rpcport=$rpcport $*
}

call $argv

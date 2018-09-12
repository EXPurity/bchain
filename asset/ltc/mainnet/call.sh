#!/usr/bin/env bash

liteclient=litecoin-cli

argv=$*
rpcconnect=127.0.0.1
rpcport=9332
rpcuser=litecoin
rpcpassword=123

liteoption="-rpcuser=$rpcuser
  -rpcpassword=$rpcpassword
  -rpcconnect=$rpcconnect
  -rpcport=$rpcport"

function call
{
  $liteclient $liteoption $*
}

call $argv

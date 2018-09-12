#!/usr/bin/env bash

datadir=$PWD/chain
rpcuser=monero
rpcpassword=123
rpcbindip=0.0.0.0
rpcbindport=18081

function start_mainnet
{
  monerod --rpc-bind-ip=$rpcbindip \
    --confirm-external-bind \
    --rpc-bind-port=$rpcbindport \
    --data-dir=$datadir \
    --detach
}

start_mainnet

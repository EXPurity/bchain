#!/usr/bin/env bash

datadir=$PWD/chain
password=112233445566
daemonport=18081
daemonhost=127.0.0.1
rpcbindip=0.0.0.0
rpcbindport=18083
rpcuser=monero
rpcpassword=123

# --daemon-login=monero:123 \
# --rpc-login=$rpcuser:$rpcpassword \
# --rpc-access-control-origins=*

function start_wallet
{
  monero-wallet-rpc --wallet-file=$datadir/wallet \
    --password=$password \
    --daemon-host=$daemonhost \
    --daemon-port=$daemonport \
    --trusted-daemon \
    --disable-rpc-login \
    --rpc-bind-ip=$rpcbindip \
    --confirm-external-bind \
    --rpc-bind-port=$rpcbindport
}

start_wallet

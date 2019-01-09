#!/usr/bin/env bash

testnet=1
app=monero-wallet-rpc
daemon_ip=127.0.0.1
bindip=0.0.0.0
datadir=$PWD/chain
password=Aa12345Bb67890
walletdir=$datadir/wallet
wallet_opt=--wallet-dir=$walletdir
detach=--detach

if (( 1 == $testnet )); then
  daemon_port=28081
  bindport=28083
  testnet=--testnet
else
  daemon_port=18081
  bindport=18083
  testnet=
fi

if [ ! -z "$2" ]; then
  bindport=$2
fi

if [ ! -z "$3" ]; then
  wallet_opt="--wallet-file $walletdir/$3 --password=$password"
fi

function start_wallet
{
  $app $testnet \
    $wallet_opt \
    --daemon-host $daemon_ip \
    --daemon-port $daemon_port \
    --trusted-daemon \
    --rpc-bind-ip $bindip \
    --confirm-external-bind \
    --disable-rpc-login \
    --rpc-bind-port=$bindport \
    $detach
}

function stop_wallet
{
  curl -X POST \
  http://localhost:$bindport/json_rpc \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: ac14351e-4120-4b40-8e0f-2ceb7eb42200' \
  -H 'cache-control: no-cache' \
  -d '{"jsonrpc":"2.0","id":"0","method":"stop_wallet"}'
}

function showhelp
{
  echo $0 \[ \<stop\> \[port\] \| \<start\> \[\<port\> \[wallet name\]\] \]
}

case "$1" in
  "start") start_wallet;;
  "stop") stop_wallet;;
  *) showhelp; exit 1;;
esac

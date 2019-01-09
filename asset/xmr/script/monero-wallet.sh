#!/usr/bin/env bash

testnet=1

datadir=$PWD/chain
comp_wallet=comp_multi
center_wallet0=cold_multi0
center_wallet1=cold_multi1

function showhelp
{
  echo $(basename $0) \[ hot \| comp \| center0 \| center1 \| all \| stop \< hot \| comp \| \
    center0 \| center1 \| all \> \]
}

hot_rpcport=18083
comp_rpcport=18084
center0_rpcport=18085
center1_rpcport=18086

if (( 1 == $testnet )); then
  let hot_rpcport+=10000
  let comp_rpcport+=10000
  let center0_rpcport+=10000
  let center1_rpcport+=10000
fi

function runas
{
  rpcport=$1
  wallet=$2

  if [ "all" == "$rpcport" ]; then
    rpcport="$hot_rpcport $comp_rpcport $center0_rpcport $center1_rpcport"
  fi

  if [ ! -z "$wallet" -a ! -f "$datadir/wallet/$wallet" ]; then
    echo wallet file $wallet not found
    exit 1
  fi

  for port in $rpcport; do
    sudo runuser xmr -c "export PATH=\$PATH:../bin;./monero-walletd.sh start $port $wallet"
  done
}

function stop_wallet
{
  case "$1" in
    "hot") rpcport=$hot_rpcport;;
    "comp") rpcport=$comp_rpcport;;
    "center0") rpcport=$center0_rpcport;;
    "center1") rpcport=$center1_rpcport;;
    "all") rpcport="$hot_rpcport $comp_rpcport $center0_rpcport $center1_rpcport";;
    *) showhelp; exit 1;;
  esac

  for port in $rpcport; do
    curl -X POST \
      http://127.0.0.1:$port/json_rpc \
      -H 'Content-Type: application/json' \
      -H 'Postman-Token: b758f0a1-8ba7-413d-bae5-50f072cbde01' \
      -H 'cache-control: no-cache' \
      -d '{"jsonrpc":"2.0","id":"0","method":"stop_wallet"}'
  done
}

case "$1" in
  "hot") runas $hot_rpcport;;
  "comp") runas $comp_rpcport;;
  "center0") runas $center0_rpcport;;
  "center1") runas $center1_rpcport;;
  "all") runas all;;
  "stop") stop_wallet $2;;
  *) showhelp; exit 1;;
esac

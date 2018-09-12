#!/usr/bin/env bash

pid=$(lsof -i @0.0.0.0:28083 | sed '2p;d' | awk '{print $2}')
if test "" == "$pid"; then
  echo start testnet
  nohup ./testnet-wallet.sh &
fi

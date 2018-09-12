#!/usr/bin/env bash

pid=$(lsof -i @0.0.0.0:18083 | sed '2p;d' | awk '{print $2}')
if test "" == "$pid"; then
  echo start mainnet
  nohup ./mainnet-wallet.sh &
fi

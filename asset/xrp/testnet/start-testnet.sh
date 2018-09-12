#!/usr/bin/env bash

pid=$(ps -e | grep rippled | awk '{print $1}')
if test "" == "$pid"; then
  echo start testnet
  nohup ./testnet.sh &
fi

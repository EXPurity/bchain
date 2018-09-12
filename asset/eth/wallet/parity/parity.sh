#!/usr/bin/env bash

datadir=/Users/epurity/Public/oneroot/asset/eth/testnet/chain

function run
{
  Parity\ Ethereum --testnet --datadir="$datadir"
}

run

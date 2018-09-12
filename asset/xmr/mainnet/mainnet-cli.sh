#!/usr/bin/env bash

datadir=$PWD/chain
password=112233445566
daemonport=18081
daemonhost=127.0.0.1

# Generate new wallet
function generate_wallet
{
  monero-wallet-cli --generate-new-wallet=$PWD/chain/wallet \
    --daemon-port=18081
}

function call_command
{
  monero-wallet-cli --wallet-file=$datadir/wallet \
    --password=$password \
    --daemon-login=monero:123 \
    --daemon-host=$daemonhost \
    --daemon-port=$daemonport \
    --trusted-daemon \
    $*
}

call_command $*

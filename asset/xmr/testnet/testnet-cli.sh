#!/usr/bin/env bash

datadir=$PWD/chain
password=112233445566
daemonport=28081
daemonhost=127.0.0.1

# Generate new wallet
function generate_wallet
{
  monero-wallet-cli --testnet \
    --generate-new-wallet=$PWD/chain/wallet \
    --daemon-port=28081
}

function call_command
{
  monero-wallet-cli --testnet \
    --wallet-file=$datadir/wallet \
    --password=$password \
    --daemon-login=monero:123 \
    --daemon-host=$daemonhost \
    --daemon-port=$daemonport \
    --trusted-daemon \
    $*
}

call_command $*

# Mist Browser

## Creating a local private net
### Initialisation
geth --datadir /path/to/datadir init priccgenesis.json
### Run node
geth --rpc --rpccorsdomain "*" --datadir "/path/to/chain" --rpcaddr 0.0.0.0 \
--rpcport 9988 --rpcapi "db,eth,net,web3,personal" --networkid 15 console

## Initialisation
cd /path/to/mist
yarn

## Run Mist
yarn dev:electron --mode mist --rpc http://localhost:998

## Run Wallet
yarn dev:meteor
### method 1. Connecting to node via HTTP instead of IPC
yarn dev:electron --mode wallet --rpc http://localhost:9988
### method 2. Passing options to Geth
#### 2.1 --mode <wallet|mist>
yarn dev:electron --rpc /path/to/geth.ipc --mode wallet
#### 2.2 --node-rpcport 9988
yarn dev:electron --rpc http://localhost --mode wallet --node-rpcport 9988
#### 2.3 --node-networkid 15
yarn dev:electron --rpc http://localhost --mode wallet --node-networkid 15

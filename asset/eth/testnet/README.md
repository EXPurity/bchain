# Testnet - Testing Network

## [说明](https://github.com/ethereum/ropsten)
  使用Ropsten测试网络，具体方法可以参考github上的说明。

## 启动节点
  ```
  datadir=$PWD/chain
  cachedir=$datadir/geth/ethash
  dagdir=$datadir/geth/ethahsh
  rpcaddr=0.0.0.0
  rpcport=8545
  rpcapi=db,eth,net,web3,personal
  networkid=3 #ropsten
  syncmode=fast
  console=console
  geth --testnet --rpc --rpcapi "$rpcapi" --rpccorsdomain "*" \
  --datadir "$datadir" --ethash.cachedir "$cachedir" \
  --ethash.dagdir "$dagdir" --rpcaddr $rpcaddr --rpcport $rpcport \
  --networkid $networkid --syncmode "$syncmode" $console
  ```

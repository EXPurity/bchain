# 搭建私链

## 初始化节点
  ```
  geth --datadir "chain" init priccgenesis.json
  ```

## 启动节点
  ```
  geth --rpc --rpccorsdomain "*" --datadir "chain" --port "30303"  \
  --rpcapi "db,eth,net,web3" --networkid 95518 console
  ```

## 注意
  extraData域需要用十六进制编码，并且以0x开头，比如0x6d616f62656e636f6e67。

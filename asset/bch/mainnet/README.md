# 比特现金主网

## 说明
  比特现金钱包是从比特币核心钱包分叉而来，基本上与比特比核心钱包功能相同，为了
  与比特币核心钱包命令区分开来，我们可以重命名比特现金钱包命令，即将包含
  `bitcoin`的命令改成包含`bitcash`的命令。

## 启动主节点
  ```
  bitserver=bitcashd
  bitoption=-conf=./bitcoin.conf -daemon
  $bitserver $bitoption
  ```

## 配置主节点
  ```bitcoin.conf
  testnet=0
  txindex=1
  rpcbind=<addr>
  rpcuser=<user>
  rpcpassword=<pw>
  rpcallowip=<ip1>
  rpcallowip=<ip2>
  ```

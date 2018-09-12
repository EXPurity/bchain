# 比特币主网

## 启动主节点
  ```
  bitserver=bitcoind
  bitoption=-conf=./bitcoin.conf -daemon
  $bitserver $bitoption
  ```

## 配置主节点
  ```bitcoin.conf
  gen=1
  txindex=1
  #rpcbind=<addr>
  #rpcuser=<user>
  #rpcpassword=<pw>
  #rpcallowip=<ip1>
  #rpcallowip=<ip2>
  ```

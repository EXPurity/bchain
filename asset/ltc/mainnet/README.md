# 比特币主网

## 启动主节点
  ```
  liteserver=litecoind
  liteoption=-conf=./litecoin.conf -daemon
  $liteserver $liteoption
  ```

## 配置主节点
  ```litecoin.conf
  gen=1
  txindex=1
  #rpcbind=<addr>
  #rpcuser=<user>
  #rpcpassword=<pw>
  #rpcallowip=<ip1>
  #rpcallowip=<ip2>
  ```

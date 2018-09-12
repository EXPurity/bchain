# DASH主网

## 启动主节点
  ```
  dashserver=dashd
  datadir=chain
  confname=dash.conf
  dashoption=-conf=$confname -datadir=$datadir -daemon
  $dashserver $dashoption
  ```

## 配置主节点
  ```dash.conf
  testnet=0
  txindex=1
  rpcbind=<addr>
  rpcuser=<user>
  rpcpassword=<pw>
  rpcallowip=<ip1>
  rpcallowip=<ip2>
  ```

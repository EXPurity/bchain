# Testnet - Testing Network

## [说明](https://en.bitcoin.it/wiki/Testnet)
  测试网络是一个用于测试的比特比区块链，测试网络中的币与比特币是隔离的，其没有
  任何价值。这里面的币是为开发人员实验用的，不会对比特币产生影响。

## 与主网的区别
  + 默认的网络协议监听端口是18333，而不是8333
  + 默认的RPC连接端口是18332，而不是8332
  + Bootstrapping使用不同的DNS种子。
  + 不同的ADDRESSVERSION值以保证测试网络的账户地址不会对生产网络造成影响。
    (使用0x6F而不是0x00)
  + 协议头部大小为0x0B110907（而不是0xF9BEB4D9）
  + 测试网络的的挖矿难度是主网络挖矿难度的一半。
  + 创世区块不同
  + IsStandard检查被禁止，因此可以实验一些非标准的交易。

## 启动测试网络节点
  ```
  datadir=./chain
  rpcuser=test
  rpcpassword=123
  rpcbind1=127.0.0.1
  rpcbind2=192.168.1.10
  rpcallowip1=127.0.0.1
  rpcallowip2=192.168.1.56
  bitcoind -testnet -datadir=$datadir -rpcbind=$rpcbind1 -rpcbind=$rpcbind2 \
  -rpcallowip=$rpcallowip1 -rpcallowip=$rpcallowip2 -rpcuser=$rcpuser \
  -rpcpassword=$rpcpassword --deprecatedrpc=accounts -daemon
  ```
  注意：启用该网络需要同步14G（更大）的区块数据。

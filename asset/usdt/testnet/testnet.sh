# 启用测试网络

datadir=../../btc/testnet/chain
rpcuser=bitcoin
rpcpassword=123
rpcbind1=127.0.0.1
rpcbind2=192.168.1.183
rpcallowip1=127.0.0.1
rpcallowip2=192.168.1.183

omnicored -testnet \
  -rpcbind=$rpcbind1 \
  -rpcbind=$rpcbind2 \
  -rpcallowip=$rpcallowip1 \
  -rpcallowip=$rpcallowip2 \
  -datadir=$datadir \
  -rpcuser=$rpcuser \
  -rpcpassword=$rpcpassword \
  -deprecatedrpc=accounts \
  -daemon \
  -txindex
  #-reindex

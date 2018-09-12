# 私链环境搭建

# 初始化
#geth --datadir "chain" init priccgenesis.json

## 启动
geth --rpc --rpccorsdomain "*" --datadir "chain" --rpcaddr 0.0.0.0 \
--rpcport 9988 --rpcapi "db,eth,net,web3,personal" --networkid 15 console

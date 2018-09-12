# 公链节点搭建

## 默认区块存储路径
  ```
  Mac: ~/Library/Ethereum
  Linux: ~/.ethereum
  Windows: %APPDATA%\Ethereum
  ```

## 配置bootnode节点
1. 将节点写入<datadir>/static-nodes.json中：
  ```
  [
    "enode://0023b7c8e097a86ef97d5e8960edd9cfac4f4e926f413273785579f868b9f83b5990d47e075e1bd289e8abfabc58766a8698b585572da96584acf7b44585df64@119.23.136.252:38358"
  ]
  ```
2. 直接在命令行指定节点
  ```
  geth --bootnodes "enode://pubkey1@ip1:port1 enode://pubkey2@ip2:port2"
  ```

## 启动节点
  ```
  geth --datadir "path/to/datadir" [--bootnodes "enode://pubkey@ip:port..."]
  ```

## 打开命令行钱包
  ```
  geth --datadir "path/to/datadir" attach
  ```

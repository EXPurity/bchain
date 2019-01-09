# 门罗币节点搭建说明

## 节点安装
  1. 运行脚本`monero_centos.sh`脚本
  2. 使用`make [mainnet | testnet]`安装脚本到家目录下的bin目录下

## 节点启动
  - 启动节点服务
    运行`runas.sh`脚本即可。
  - 启动钱包服务
    0. 启动钱包服务
      ```bash
      monero-wallet.sh [hot | comp | center0 | center1 | all | stop [hot | comp | center0 | center1] ]
      ```
      hot 热钱包服务；comp 分仓钱包服务；center0 中心钱包服务；center1 出纳钱包服务。也可以使用
      `monero-walletd.sh`脚本启动。
    1. 启动热钱包服务
      ```bash
      monero-walled.sh start
      ```
      热钱包服务端口是18083（测试网是28083）。
    2. 启动分仓钱包服务
      ```bash
      monero-walled.sh start 18084 comp_multi
      ```
      分仓钱包服务端口是18084（测试网是28084）。
    3. 启动中心钱包服务
      ```bash
      monero-walled.sh start 18085 cold_multi0
      ```
      中心钱包服务端口是18085（测试网是28085）。
    4. 启动出纳钱包服务
      ```bash
      monero-walled.sh start 18086 cold_multi1
      ```
      分仓钱包服务端口是18086（测试网是28086）。

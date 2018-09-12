# omnicore环境搭建

## omnicore是以bitcoin为基础的，在其上加入了omni layer，以方便扩展。

## 源码下载
git clone https://github.com/OmniLayer/omnicore.git

## 依赖项安装
brew reinstall automake berkeley-db4 libtool boost miniupnpc openssl protobuf \
  libevent pkg-config

## 编译源码
### 在mac下编译的时候可能会编译报错，原因在于miner.h和txmempool.h头文件中的的
### 一些括号重载运算符没有加const限定符造成的，例如：
### method is not marked const
### bool operator()(const CTxMemPoolEntry& a, const CTxMemPoolEntry& b)
./autogen.sh && ./configure && make && make check

## rpc接口封装
pip install python-bitcoinrpc

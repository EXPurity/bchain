#!/usr/bin/env bash

# 以太坊环境搭建

## 源码下载
git clone https://github.com/ethereum/go-ethereum.git

## 依赖项安装
apt install -y build-essential golang

## 编译源码
make geth

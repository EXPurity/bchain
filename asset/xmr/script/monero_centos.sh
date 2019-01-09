#!/usr/bin/env bash

# 门罗币环境搭建

user=xmr
group=xmr
root=$HOME

version=0.13.0.4
app_tar=monero-linux-x64-v$version.tar.bz2

# 下载二进制文件
mkdir -p .monero_ && cd .monero_
wget https://github.com/monero-project/monero/releases/download/v$version/$app_tar && tar xvjf $app_tar

if (( 0 != $? )); then
  echo Failed to download $app_tar
  cd .. && rm -rf .monero_
  exit 1
fi

mkdir -p $root/bin
cp -v monero-v$version/* $root/bin && cd .. && rm -rf .monero_

sudo mkdir -p $root/$user/chain/wallet
if test -z "$(sudo grep $user /etc/passwd)"; then
  sudo useradd -d $root/$user -G $USER -s /usr/bin/bash -U $user
fi
sudo chown -R $user:$group $root/$user

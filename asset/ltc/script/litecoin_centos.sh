#!/usr/bin/env bash

# 莱特币环境搭建

eth0ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')

if test "testnet" == "$1"; then
  testnet=1
  txindex=1
  rpcport=19332
  user=ltc
  group=ltc
  datadir=ltc
else
  testnet=0
  txindex=1
  rpcport=9332
  user=ltc
  group=ltc
  datadir=ltc
fi

rpcauth=litecoin:82a6eedb5e1d83d75af321fefcab3e2\$f343e630bef6db1f1c9861c48bc654a462decbdb68d3550af163a70b76f246a1
rpcuser=litecoin
rpcpwd=G3aNIjgOOp383UI5LBCRCJwe8wsFthXzUqA3yvVBd1M\=
rpcconnect=127.0.0.1

preversion=0.16.2
version=0.16.3

## 依赖项安装
sudo yum -y install gcc-c++ libtool make autoconf automake openssl-devel libevent-devel boost-devel libdb-devel libdb-cxx-devel python3

if (( 0 != $? )); then
  echo Failed to install dependencies!
  exit 1
fi

## 源码下载
mkdir -p .litecoin && cd .litecoin
wget https://github.com/litecoin-project/litecoin/archive/v$version.tar.gz \
  && mv v$version.tar.gz litecoin-$version.tar.gz \
  && tar xvzf litecoin-$version.tar.gz

if (( 0 != $? )); then
  echo Failed to download https://github.com/litecoin-project/litecoin/archive/v$version.tar.gz
  cd .. && rm -rf .litecoin
  exit 1
fi

## 编译源码
cd litecoin-$version && ./autogen.sh \
  && ./configure --with-incompatible-bdb --without-gui --without-miniupnpc \
  && make -j 2

if (( 0 != $? )); then
  echo Failed to compile source code!
  cd ../.. && rm -rf .litecoin
  exit 1
fi

mkdir -p ~/bin
if [ -x ~/bin/litecoind ]; then
  mv ~/bin/litecoind ~/bin/litecoind-$preversion
fi
if [ -x ~/bin/litecoin-cli ]; then
  mv ~/bin/litecoin-cli ~/bin/litecoin-cli-$preversion
fi
cp src/litecoind src/litecoin-cli ~/bin
cd ../../ && rm -rf .litecoin

cat > litecoin.conf << EOF
# 配置文件所在目录：
# Windows: %APPDATA%\\Litecoin\\
# OSX: \$HOME/Library/Application Support/Litecoin/
# Linux: \$HOME/.litecoin/

# 使用测试网络
testnet=$testnet
# 指定用户名和密码
rpcauth=$rpcauth
rpcuser=$rpcuser
rpcpassword=$rpcpwd
# rpc cient connect ip
rpcconnect=$rpcconnect
# 指定监听IP，需要和rpcallowip结合使用，否则无效
rpcport=$rpcport
rpcbind=127.0.0.1
rpcbind=$eth0ip
# 指定允许的通过RPC的IP
rpcallowip=127.0.0.1
rpcallowip=$eth0ip/16
txindex=$txindex
EOF

cat > runas.sh << EOF
#!/usr/bin/env bash

sudo runuser $user -c 'export PATH=$PATH:../bin;./litecoind.sh start'
EOF

mkdir -p ~/$datadir/chain
sudo cp litecoin-cli.sh litecoind.sh litecoin.conf runas.sh ~/$datadir
if test -z "$(sudo grep $user /etc/passwd)"; then
  sudo useradd -d ~/$datadir -G $USER -s /usr/bin/bash -U $user
fi
sudo chown -R $user:$group ~/$datadir
cd ~/$datadir
./runas.sh

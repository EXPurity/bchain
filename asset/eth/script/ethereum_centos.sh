#!/usr/bin/env bash

eth0ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')

rpcaddr=$eth0ip
rpcapi="\"eth\",\"net\",\"web3\",\"personal\",\"txpool\""
wsapi="\"net\",\"web3\",\"eth\",\"shh\""
syncmode=full

if test "testnet" == "$1"; then
  networkid=3
  rpcport=18545
  wsport=18546
  user=eth
  group=eth
  datadir=$HOME/eth
  testnet="--testnet"
else
  networkid=1
  rpcport=8545
  wsport=8546
  user=eth
  group=eth
  datadir=$HOME/eth
  testnet=
fi

preversion=1.8.14
version=1.8.15

## 依赖项安装
sudo yum install -y golang

if (( 0 != $? )); then
  echo Failed to install dependencies!
  exit 1
fi

## 源码下载
mkdir -p .ethereum && cd .ethereum
wget https://github.com/ethereum/go-ethereum/archive/v$version.tar.gz \
  && mv v$version.tar.gz go-ethereum-$version.tar.gz \
  && tar xvzf go-ethereum-$version.tar.gz

if (( 0 != $? )); then
  echo Failed to download https://github.com/ethereum/go-ethereum/archive/v$version.tar.gz
  cd .. && rm -rf .ethereum
  exit 1
fi

## 编译源码
cd go-ethereum-$version && make -j 2 all

if (( 0 != $? )); then
  echo Failed to compile source code!
  cd ../.. && rm -rf .ethereum
  exit 1
fi

mkdir -p ~/bin
if [ -x ~/bin/geth ]; then
  mv ~/bin/geth ~/bin/geth-$preversion
fi
if [ -x ~/bin/ethkey ]; then
  mv ~/bin/ethkey ~/bin/ethkey-$preversion
fi
cp build/bin/geth build/bin/ethkey ~/bin
cd ../.. && rm -rf .ethereum

mkdir -p $datadir/chain

cachedir=$datadir/chain/geth/ethash
dagdir=$datadir/chain/geth/ethahsh

cat > ethereum.toml << EOF
[Eth]
NetworkId = $networkid
SyncMode = "$syncmode"
LightPeers = 100
DatabaseCache = 230
EnablePreimageRecording = false

[Eth.Ethash]
CacheDir = "$cachedir"
CachesInMem = 2
CachesOnDisk = 3
DatasetsInMem = 0
DatasetsOnDisk = 2
PowMode = 0

[Eth.TxPool]
NoLocals = false
Journal = "transactions.rlp"
Rejournal = 3600000000000
PriceLimit = 1
PriceBump = 10
AccountSlots = 16
GlobalSlots = 4096
AccountQueue = 64
GlobalQueue = 1024
Lifetime = 10800000000000

[Eth.GPO]
Blocks = 20
Percentile = 60

[Shh]
MaxMessageSize = 1048576
MinimumAcceptedPOW = 2e-01

[Node]
DataDir = "$datadir/chain"
UseLightweightKDF = true
IPCPath = "geth.ipc"
HTTPHost = "$rpcaddr"
HTTPPort = $rpcport
HTTPCors = []
HTTPVirtualHosts = ["localhost"]
HTTPModules = [$rpcapi]
WSPort = $wsport
WSModules = [$wsapi]

[Node.P2P]
MaxPeers = 25
NoDiscovery = false
StaticNodes = []
TrustedNodes = []
ListenAddr = ":30303"
EnableMsgEvents = false

[Dashboard]
Host = "localhost"
Port = 8080
Refresh = 5000000000
EOF

cat > runas.sh << EOF
#!/usr/bin/env bash

sudo runuser $user -c 'export PATH=$PATH:../bin;./gethd.sh start'
EOF

cat > geth.sh << EOF
#!/usr/bin/env bash

geth --config $datadir/ethereum.toml --datadir $datadir/chain \\
  --ethash.cachedir $datadir/chain/geth/ethash \\
  --ethash.dagdir $datadir/chain/geth/ethahsh \\
  --networkid $networkid $testnet
EOF

sudo cp ethereum.toml geth-cli.sh geth.sh gethd.sh runas.sh $datadir
if test -z "$(sudo grep eth /etc/passwd)"; then
  sudo useradd -d ~/$user -G $USER -s /usr/bin/bash -U $user
fi
sudo chown -R $user:$group $datadir
cd $datadir
./runas.sh

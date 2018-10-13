#!/usr/bin/env bash

# 瑞波币环境搭建

eth0ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')

if test "testnet" == "$1"; then
else
fi

version=1.0.0

## 依赖项安装
sudo yum install -y gcc gcc-c++ cmake protobuf-compiler libprotobuf-devel \
  openssl-libs && mkdir -p .ripple && cd .ripple \
  && wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz \
  && tar -xzf boost_1_67_0.tar.gz && cd boost_1_67_0 && ./bootstrap.sh \
  && ./b2 headers && ./b2 -j 2 && export BOOST_ROOT=$PWD

if (( 0 != $? )); then
  echo Failed to install dependencies!
  cd ../.. && rm -rf .ripple
  exit 1
fi

cd ..

## 源码下载
wget https://github.com/ripple/rippled/archive/$version.tar.gz \
  && mv $version.tar.gz ripple-$version.tar.gz && tar xvzf ripple-$version.tar.gz

if (( 0 != $? )); then
  echo Failed to download wget https://github.com/ripple/rippled/archive/$version.tar.gz
  cd .. && rm -rf .ripple
  exit 1
fi

## 编译源码
cd ripple-$version && mkdir -p build && cd build \
  && cmake -Dtarget=gcc.release.unity.profile .. && cmake --build .

if (( 0 != $? )); then
  echo Failed to compile source code!
  cd ../../.. && rm -rf .ripple
  exit 1
fi

mkdir -p ~/bin
cp rippled ~/bin
cd ../../.. && rm -rf .ripple

cat > ripple.conf << EOF
[server]
port_rpc_admin_local
port_peer
port_ws_admin_local
#port_ws_public
#ssl_key = /etc/ssl/private/server.key
#ssl_cert = /etc/ssl/certs/server.crt

[port_rpc_admin_local]
port = 5005
ip = 0.0.0.0
admin = 0.0.0.0
protocol = http

[port_peer]
port = 51235
ip = 0.0.0.0
protocol = peer

[port_ws_admin_local]
port = 6006
ip = 127.0.0.1
admin = 127.0.0.1
protocol = ws

#[port_ws_public]
#port = 5005
#ip = 127.0.0.1
#protocol = wss

[node_size]
medium

# This is primary persistent datastore for rippled.  This includes transaction
# metadata, account states, and ledger headers.  Helpful information can be
# found here: https://ripple.com/wiki/NodeBackEnd
# delete old ledgers while maintaining at least 2000. Do not require an
# external administrative command to initiate deletion.
[node_db]
type=RocksDB
path=/root/data/xrp/db/rocksdb
open_files=2000
filter_bits=12
cache_mb=256
file_size_mb=8
file_size_mult=2
#online_delete=2000
advisory_delete=0

# This is the persistent datastore for shards. It is important for the health
# of the ripple network that rippled operators shard as much as practical.
# NuDB requires SSD storage. Helpful information can be found here
# https://ripple.com/build/history-sharding
#[shard_db]
#type=NuDB
#path=/var/lib/rippled/db/shards/nudb
#max_size_gb=500

[database_path]
/root/data/xrp/db

# This needs to be an absolute directory reference, not a relative one.
# Modify this value as required.
[debug_logfile]
/var/log/rippled/debug.log

[sntp_servers]
time.windows.com
time.apple.com
time.nist.gov
pool.ntp.org

# Where to find some other servers speaking the Ripple protocol.
#[ips]
#r.ripple.com 51235

# To use the XRP test network (see https://ripple.com/build/xrp-test-net/),
# use the following [ips] section instead:
[ips]
r.altnet.rippletest.net 51235

# File containing trusted validator keys or validator list publishers.
# Unless an absolute path is specified, it will be considered relative to the
# folder in which the rippled.cfg file is located.
[validators_file]
validators.txt

# Turn down default logging to save disk space in the long run.
# Valid values here are trace, debug, info, warning, error, and fatal
[rpc_startup]
{ "command": "log_level", "severity": "warning" }

# If ssl_verify is 1, certificates will be validated.
# To allow the use of self-signed certificates for development or internal use,
# set to ssl_verify to 0.
[ssl_verify]
1

[ledger_history]
full
EOF

mkdir -p ~/xrp/chain
cp rippled.sh ripple.conf runas.sh ~/xrp
if test -z "$(sudo grep xrp /etc/passwd)"; then
  sudo useradd -d ~/xrp -G $USER -s /usr/bin/bash -U xrp
fi
sudo chown -R xrp:xrp ~/xrp
cd ~/xrp
./runas.sh

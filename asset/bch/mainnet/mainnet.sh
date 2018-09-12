# 启用主链网络

bitserver=bitcashd

mkdir -p chain
cp bitcoin.conf chain/

datadir=chain
confpath=bitcoin.conf
bitoption="
  -conf=$confpath
  -datadir=$datadir
  -daemon"

$bitserver $bitoption

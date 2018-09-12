# 启用主链网络

dashserver=dashd

mkdir -p chain
cp dash.conf chain/

datadir=chain
confname=dash.conf
dashoption="
  -conf=$confname
  -datadir=$datadir
  -daemon"

$dashserver $dashoption

#!/usr/bin/env bash

argv=$*
rpcconnect=127.0.0.1
#rpcconnect=47.96.111.40
rpcwallet=""
rpcport=18332
rpcuser=bitcoin
rpcpassword=123

createrawtransaction='createrawtransaction
  [{"txid":"8fa428fd970e61711f00858d52a37d4cdc64e7445dc2cf96b6c41fb421833f60","vout":0}]
  [{"2N85yM7RhhqF39rsYzvV18NHWdJKzvsFNWN":0}]'
multisigaddress='addmultisigaddress 2 "[\"2MxyeEGaddJ7jtJhmDvvh6CYxJGF86mbCvV\", \"2N2KhszfRhf5zEvyVnaBpXsexBejMsYqgqF\"]" bitcoin'
sendmany='sendmany "bitcoin" "{\"2MxyeEGaddJ7jtJhmDvvh6CYxJGF86mbCvV\":0.0001, \"2N2KhszfRhf5zEvyVnaBpXsexBejMsYqgqF\":0.0001}"'
signrawtransactionwithkey='signrawtransactionwithkey
  0200000001836a1f67bdfbd088414120dd62aac045661e0b0e21883ded1ff5644489b3524e0000000000ffffffff0150c300000000000017a914a2c9ebe6cf7cbf2a3b46bdc2eed31033c9a375238700000000
  ["cS51QpAGQqNJVjSTYoKXpTLPGx1uNLikRYzHh8C1oAYUqRXXPx6s","cS5TCgcmtLd2uiahJxMBuS2nSGYB4ij8ofiqrTXDWYxNtPWGFQRv"]
  [{"txid":"4e52b3894464f51fed3d88210e0b1e6645c0aa62dd20414188d0fbbd671f6a83","vout":0,"scriptPubKey":"a9149bf51b4770048d581401278a727b87195d03ae7f87","redeemScript":"5221022d781e5af60eef12e9fcf4b9113fcbb93411834e5bda569b0c7220c48323ba022102b7129998014cecfe1890bcdaf4531df9221d022c0dcb50f04980753044e80cef52ae","amount":0.001}]'
walletpassphrase='walletpassphrase 123 30'
signrawtransactionwithwallet='signrawtransactionwithwallet
  0200000001603f8321b41fc4b696cfc25d44e764dc4c7da3528d85001f71610e97fd28a48f0000000000ffffffff01a08601000000000017a914a2c9ebe6cf7cbf2a3b46bdc2eed31033c9a375238700000000'
signedrawtransaction='02000000000101603f8321b41fc4b696cfc25d44e764dc4c7da3528d85001f71610e97fd28a48f00000000171600141532ad18ea069c0a6497c4d466d68eccf927a491ffffffff01a08601000000000017a914a2c9ebe6cf7cbf2a3b46bdc2eed31033c9a37523870247304402201d03ecf2f855e1099ea481dd166910f5e714d520bd6c3b3f37af45bd3aca88f7022025a3e568830f94c587c936091d3de23ed0643fb20be4f53cc172e34c2d70e2b60121022d781e5af60eef12e9fcf4b9113fcbb93411834e5bda569b0c7220c48323ba0200000000'

function call
{
  bitcoin-cli \
    -testnet \
    -rpcwallet=$rpcwallet \
    -rpcuser=$rpcuser \
    -rpcpassword=$rpcpassword \
    -rpcconnect=$rpcconnect \
    -rpcport=$rpcport \
    $*
}

call $argv

# stop 关闭节点
# help 帮助命令
# abandontransaction <txid> 放弃指定交易
# backupwallet <dest> 备份钱包到指定位置
# addmultisigaddress <nrequired> <pubkeys> [account] 添加多重签名地址
# createrawtransaction <inputs> <outputs> 创建一个消费制定输入到指定输出的交易
# dumpprivkey <address> 获取指定地址对应的私钥
# getaccount <address> 获取指定地址对应的账号
# getaccountaddress [account] 生成新的地址
# getblockchaininfo 获取区块链信息
# getnetworkinfo 获取节点网络信息
# getwalletinfo 获取钱包信息
# getnewaddress [account] 生成新地址
# getaddressesbyaccount <account> 获取对应的账号的地址
# getrawmempool [verbose] 获取最近发生变动的比特币地址的交易信息
# getreceivedbyaddress <address> 获取对应地址收到的资产
# getreceivedbyaccount <account> 获取对应账户收到的资产
# getaccount <address> 获取对应地址的账户
# getaccountaddress <account> 获取对应账户的地址
# getbalance [account] 获区账户（账户没有指定，获取该节点下的所有）的余额
# getblockcount 获取区块总数
# getblockhash <index> 获取指定区块的区块哈希
# getblock <hash> 获取区块信息
# gettransaction <txhash> 获取交易信息
# listaccounts [<confirmations> [watch-only]] 列出钱包的账号和余额
# listaddressgroupings 分组查看地址与资产
# listunspent [minconfirmations] [maxconfirnmations] [address]
#   获取没有消费的输出
# signrawtransactionwithkey <hexstring> <privkeys> [prevtxs] [sighashtype]
#   用私钥对交易签名，对于多重钱包prevtxs需要指定
# signrawtransactionwithwallet <hexstring> <prevtxs> [sighashtype]
#   用当前钱包对交易签名
# sendfrom <account> <address> <amount> [confirmations] [comment] [comment to]
# sendmany <account> <addresses:amounts> [confirmations] [comment]
# sendtoaddress <address> <amount> [comment] [comment to]
# validateaddress <address> 验证指定地址

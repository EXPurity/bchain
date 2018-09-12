sudo apt-get install software-properties-common
sudo add-apt-repository ppa:bitcoin-unlimited/bu-ppa
sudo apt-get update
sudo apt-get install bitcoind bitcoin-qt

# We also can compile from source:
cat <<EOF
sudo apt-get install git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev
## optional: only needed if you want bitcoin-qt
sudo apt-get install qttools5-dev-tools qttools5-dev libprotobuf-dev protobuf-compiler libqrencode-dev
## optional: only needed if your wallet use the old format
sudo apt-get install software-properties-common

## this not needed if your wallet will use the new
## format, or if you're not going to use a wallet at all
sudo add-apt-repository ppa:bitcoin-unlimited/bu-ppa
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev

mkdir -p ~/src
cd ~/src
git clone https://github.com/BitcoinUnlimited/BitcoinUnlimited.git bu-src
cd bu-src
git checkout release
./autogen.sh
./configure
make
sudo make install
EOF

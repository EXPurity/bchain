# First add the necessary extra repository and update all packages:
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt update
sudo apt upgrade

# Install the dependencies as described in the installation documentation:
sudo apt install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git libdb4.8-dev libdb4.8++-dev
sudo apt install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libzmq3-dev
sudo apt install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler

# Download the stable Dash repository:
git clone https://github.com/dashpay/dash.git

# And build:
cd dash
./autogen.sh
./configure
make
make install

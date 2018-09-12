# 以太坊环境搭建

## 说明
### ethereum : 以太坊节点
### solidity : 智能合约编译器
### mist     : 以太坊钱包

## ubuntu
apt-get install software-properties-common
add-apt-repository -y ppa:ethereum/ethereum
add-apt-repository -y ppa:ethereum/ethereum-dev
apt-get update
apt-get install ethereum
apt-get install solc

##mist dependencies
### meteor
curl https://install.meteor.com/ | sh
### yarn
curl -o- -L https://yarnpkg.com/install.sh | bash
### electron
yarn global add electron@1.8.4
### gulp
yarn global add gulp

## mac
#brew install go
#brew tap ethereum/ethereum
#brew install ethereum
#brew install solidity
#mist dependencies
#curl https://install.meteor.com/ | sh
#curl -o- -L https://yarnpkg.com/install.sh | bash
#yarn global add electron@1.8.4
#yarn global add gulp

## 编译源码
### mac
### brew install leveldb
### windows
### scripts\install_deps.bat
### redhat
### dnf install leveldb-devel
### ubuntu
apt-get install libleveldb-dev

### linux/mac
mkdir build; cd build  # Create a build directory.
cmake ..               # Configure the project.
cmake --build .        # Build all default targets.
### windows
### cmake .. -G "Visual Studio 14 2015 Win64"

## solidity
### ubuntu
add-apt-repository ppa:ethereum/ethereum
apt-get update
apt-get install solc

### mac
### brew update
### brew upgrade
### brew tap ethereum/ethereum
### brew install solidity

### 编译源码
### mkdir build
### cd build
### cmake .. && make
### windows
### mkdir build
### cd build
### cmake -G "Visual Studio 15 2017 Win64" ..

# 以太坊命令

## 命令行

## 账户

## 挖矿
  + 直接命令行就挖矿
    ```
    geth --mine --minerthread 3 --datadir "/path/to/datadir"
    ```
  + 进入交互界面后在挖矿
    ```
    geth --datadir "/path/to/datadir"
    miner.setEtherbase(eth.accounts[0])
    miner.start(3)
    miner.stop()
    ```

## 合约
### 合约部署
  1. 合约参考实例
    ```test.sol
    pragma solidity ^0.4.2;
    contract test {
      function multiply(uint a) returns(uint d) {
        return a * 7;
      }
    }
    ```
  2. 编译智能合约
    ```
    solc --bin --abi test.sol

    ```
  3. 创建合约抽象对象
    ```
    contract = eth.contract(abi)
    ```
    abi是通过智能合约编译器编译生成的智能合约接口。
  4. 创建合约对象
    ```
    personal.unlockAccount(eth.accounts[0], 'password')
    mycontract = contract.new(
      {
        from:eth.accounts[0],
        data:'0x6060604052341561000f57600080fd5b5b60ab8061001e6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063c6888fa114603d575b600080fd5b3415604757600080fd5b605b60048080359060200190919050506071565b6040518082815260200191505060405180910390f35b60006007820290505b9190505600a165627a7a723058206f9974e7f2c8329cbc09530d06d001018bfeca369c7cd8f9d565298adbdd2a9c0029',
        gas:'300000'
      },
      function(e, contract) {
        console.log(e, contract);
        if (contract.address != 'undefined') {
          console.log("contract mined! address: " + contract.address);
        }
      })
    ```
  5. 合约交互
    ```
    multiply = contract.at(mycontract.address)
    multiply.multiply.call(7)
    ```

## 交易

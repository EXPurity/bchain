# 智能合约编码与部署

## 部署智能合约
  1. 合约实例
    ```
    pragma solidity ^0.4.2;
    contract test {
       function multiply(uint a) returns(uint d) {
           return a * 7;
       }
    }
    ```
  2. 编译合约
    ```
    sol --abi --bin test.sol
    ```
  3. 进入钱包
    ```
    geth --datadir "path/to/datadir" attach
    ```
  4. 开始部署
    ```
    abi = [{
            "constant":false,
            "inputs":[{"name":"a","type":"uint256"}],
            "name":"multiply",
            "outputs":[{"name":"d","type":"uint256"}],
            "payable":false,
            "stateMutability":"nonpayable",
            "type":"function"
          }]
    multiplyContract = eth.contract(abi)
    personal.unlockAccount(eth.accounts[0])
    multiply = multiplyContract.new(
      {
        from: web3.eth.accounts[0],
        data: '0x6060604052341561000f57600080fd5b5b60ab8061001e6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063c6888fa114603d575b600080fd5b3415604757600080fd5b605b60048080359060200190919050506071565b6040518082815260200191505060405180910390f35b60006007820290505b9190505600a165627a7a723058206f9974e7f2c8329cbc09530d06d001018bfeca369c7cd8f9d565298adbdd2a9c0029',
        gas: '300000'
      },
      function (e, contract) {
        console.log(e, contract);
        if (typeof contract.address !== 'undefined') {
           console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
        }
      })
    ```
  5. 使用合约
    上一步合约部署成功后，会得到一个合约地址，我们可以通过合约地址实例化合约。
    ```
    myContract = multiplyContract.at(multiply.address)
    myContract.multiply.call(7)
    ```

## 智能合约编码

var keythereum = require("keythereum");
var datadir = '.';
var address = '0x5b9fb709258681f295d5239df9293a8c5a8d996e';
const password = "123";
var keyObject = keythereum.importFromFile(address, datadir);
var privateKey = keythereum.recover(password, keyObject);
console.log(privateKey.toString('hex'));

var keythereum = require("keythereum");
var datadir = '.';
var address = '0x00acf74468d852dedc8566ad621064a898250040';
const password = 'v0xf4ea16zusi9ytmq7g2tctmrlu0bod';
var keyObject = keythereum.importFromFile(address, datadir);
var privateKey = keythereum.recover(password, keyObject);
console.log(privateKey.toString('hex'));

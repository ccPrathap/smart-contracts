# smart-contracts
Smart Contracts in Solidity.  

## Steps to execute Meeting.sol contract
```
Web3 = require('web3')  
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))  
code = fs.readFileSync('Meeting.sol').toString()  
contract = web3.eth.compile.solidity(code)  
MeetingContract = web3.eth.contract(contract.info.abiDefinition)  
deployedContract = MeetingContract.new([web3.eth.accounts[1],web3.eth.accounts[2],web3.eth.accounts[3]],{data: contract.code, from: web3.eth.accounts[0], gas: 4700000})  
contractInstance = MeetingContract.at(deployedContract.address)    
```

#### To get the total balance of an account:  

```
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[1]))  
```

#### To get the late count details:  

```
contractInstance.lateCount.call(web3.eth.accounts[1]).toLocaleString()    
```

#### Late time recording (only owner can record - account[0]):  

```
contractInstance.inTime(web3.eth.accounts[1], true, {from: web3.eth.accounts[0]})  
contractInstance.inTime(web3.eth.accounts[1], true, {from: web3.eth.accounts[0]})  
contractInstance.inTime(web3.eth.accounts[2], true, {from: web3.eth.accounts[0]})    
```

#### Send fee to the owner from your account account - (If no late count, then error will be thrown):  

```
contractInstance.sendFee({from: web3.eth.accounts[1], value: web3.toWei(2,"ether")})    
```

#### Check the late count balance again after payment:  

```
contractInstance.lateCount.call(web3.eth.accounts[1]).toLocaleString()  
contractInstance.lateCount.call(web3.eth.accounts[2]).toLocaleString()  
```
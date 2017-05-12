pragma solidity ^0.4.6;

contract Meeting {

  address public owner;
  mapping (address => uint8) public member;
  address[] public memberList;

  modifier isOwner() {
    if (msg.sender != owner) throw;
    _;
  }

  modifier isMember(address addr) {
    bool status = false;
    for(uint i = 0; i < memberList.length; i++) {
      if(memberList[i] == addr) {
        status = true;
      }
    }
    if(status != true) throw;
    _;
  }

  function Meeting(address[] allMembers) {
    owner = msg.sender;
    memberList = allMembers;
  }
  
  // Record late count based on in time
  function inTime(address addr, bool late) isMember(addr) isOwner() {
    if(late) {
      member[addr] += 1;
    }
  }

  // Collect fee from the members
  function sendFee() payable isMember(msg.sender) {
    if(!((member[msg.sender] > 0) && (msg.value > 0))) throw;
    member[msg.sender] = 0;
    if(!(owner.send(this.balance))) throw;
  }

  // Get late couunt by Address
  function lateCount(address addr) constant returns (uint count) {
    return member[addr];
  }
  
  function kill() isOwner() returns (bool status) {
    selfdestruct(owner);
  }

  // Default function
  function () {
     throw;
  }
}
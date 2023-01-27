// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner!"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed; // keep track of the last completed migration
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);// using the migration as a data type to grab its content and stored in 
    //a new variable called upgraded and save it into a new address, this is how you migrate since in blockchain
    //you can not change a smart contract if the contract already exist, instead you 
    //migrate to new address
    upgraded.setCompleted(last_completed_migration); // this set the last_completed migration using
    //the existing setcompleted() function
  }

}

// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;
contract Borrower {
    string public id;
    string passwd;
    string name;
    uint256 reputation;
    bool public valid;
    uint256 balance;

    constructor(
        string memory _id,
        string memory _passwd,
        string memory _name,
        uint256 _reputation
    ) public {
        id = _id;
        passwd = _passwd;
        name = _name;
        reputation = _reputation;
        valid = true;
    }

    string InnerPasswd="123456";
    function BorrowerLogin(string memory InputId) public returns(bool){
      if(keccak256(bytes(InputId))==keccak256(bytes(InnerPasswd))) return true;
      else return false;
    }

   function getBorrowerInfo() public view returns
   (string memory,string memory,uint256,uint256){
     return (id,name,reputation,balance);
   }

   function LoanApply(string memory Id,uint256 Amount) public {
     // if(check一下reputation)??
      balance += Amount;
   }

   function deleteBorrower() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

}

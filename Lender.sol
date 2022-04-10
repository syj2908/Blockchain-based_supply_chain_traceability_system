// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

contract Lender {
    //放贷者结构体
    string public id;
    string account;
    string passwd;
    string name;
    bool public valid;
    uint256[] cashFlows;

    constructor (
        string memory _id,
        string memory _account,
        string memory _passwd,
        string memory _name
    ) public {
        id = _id;
        account = _account;
        passwd = _passwd;
        name = _name;
        valid = true;
    }

    function attachCashFlow(uint256 cashFlowID) public returns (bool) {
        cashFlows.push(cashFlowID);
        return true;
    }


    string InnerPasswd="123456";
    function LenderLogin(string memory InputId) public returns(bool){
      if(keccak256(bytes(InputId))==keccak256(bytes(InnerPasswd))) return true;
      else return false;
    }

    function getLenderInfo() public view returns (
            string memory,
            string memory,
            string memory,
            uint256[] memory
        )
    {
        return (id, account, name, cashFlows);
    }

    function deleteLender() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

    
    
}

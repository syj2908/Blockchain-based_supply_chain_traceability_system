// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

contract Borrower {
    string public id;
    string passwd;
    string name;
    uint256 balance;
    uint256 reputation;
    bool public valid = true;
    uint256[] cashFlows;

    constructor(
        string memory _id,
        string memory _passwd,
        string memory _name,
        uint256 _balance,
        uint256 _reputation
    ) public {
        id = _id;
        passwd = _passwd;
        name = _name;
        balance = _balance;
        reputation = _reputation;
    }

    function attachCashFlow(uint256 cashFlowID) public returns (bool) {
        cashFlows.push(cashFlowID);
        return true;
    }

    function BorrowerLogin(string memory _passwd) public view returns (bool) {
        if (keccak256(bytes(passwd)) == keccak256(bytes(_passwd))) return true;
        else return false;
    }

    function getBorrowerInfo()
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            uint256
        )
    {
        return (id, name, balance, reputation);
    }

    function LoanApply(string memory id, uint256 Amount) public {
        // if(check一下reputation)??
        balance += Amount;
    }

    function deleteBorrower() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }
}

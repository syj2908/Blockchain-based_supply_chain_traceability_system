// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

contract Borrower {
    address public id;
    string account;
    string passwd;
    string name;
    uint256 balance;
    uint256 reputation = 100;
    bool public valid = true;
    uint256[] cashFlows;

    constructor(
        address _id,
        string memory _account,
        string memory _passwd,
        string memory _name
    ) public {
        id = _id;
        account = _account;
        passwd = _passwd;
        name = _name;
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
            address,
            string memory,
            string memory,
            uint256,
            uint256,
            uint256[] memory
        )
    {
        return (id, account, name, balance, reputation, cashFlows);
    }

    function LoanApply(address id, uint256 value) public {
        // if(check一下reputation)??
        balance += value;
    }

    function deleteBorrower() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }
}

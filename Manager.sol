// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

contract Manager {
    address public id;
    string passwd;
    bool public valid = true;

    constructor(address _id, string memory _passwd) {
        id = _id;
        passwd = _passwd;
    }

    function deleteManager() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

    function ManagerLogin(string memory _passwd) public view returns (bool) {
        if (keccak256(bytes(_passwd)) == keccak256(bytes(passwd))) return true;
        else return false;
    }
}

// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

contract Manager {
    string public id;
    string passwd;
    bool public valid;

    constructor(string memory  _id, string memory _passwd) {
        id = _id;
        passwd = _passwd;
        valid=true;
    }

    function getManagerInfo()
        public
        view
        returns (
            string  memory
        )
    {
        return (id);
    }

    function deleteManager() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

     string InnerPasswd="123456";

    function ManagerLogin(string memory InputId) public returns(bool){
      if(keccak256(bytes(InputId))==keccak256(bytes(InnerPasswd))) return true;
      else return false;
}
}

// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

library SysFunc {
    //业务无关的函数包

    function strConcat(string memory _a, string memory _b)
        public
        pure
        returns (string memory)
    {
        //字符串拼接
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ret = new string(_ba.length + _bb.length);
        bytes memory bret = bytes(ret);
        uint256 k = 0;
        for (uint256 i = 0; i < _ba.length; i++) bret[k++] = _ba[i];
        for (uint256 i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        return string(ret);
    }
}

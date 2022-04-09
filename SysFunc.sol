//该文件暂不可用

contract SysFunc {
    //业务无关的函数包
    uint256[] IDarr = [0, 0, 0]; //用户id计数器

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

    function generateID(uint8 t) public returns (string memory) {
        //产生一个用户id 作为主键
        IDarr[t]++;
        uint256 rawID = IDarr[t] - 1;
        string memory strID;
        if (rawID == 0) strID = "0";
        else {
            uint256 cp = rawID;
            uint256 len = 0;
            while (cp != 0) {
                len++;
                cp /= 10;
            }
            bytes memory bstr = new bytes(len);
            while (rawID != 0) {
                len--;
                uint8 temp = (48 + uint8(rawID - (rawID / 10) * 10));
                bytes1 b1 = bytes1(temp);
                bstr[len] = b1;
                rawID /= 10;
            }
            strID = string(bstr);
        }
        string memory prefix;
        if (t == 0) prefix = "0";
        else if (t == 1) prefix = "1";
        else prefix = "2";
        return strConcat(prefix, strID);
    }
}

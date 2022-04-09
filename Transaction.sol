contract Transaction {
    //交易数据结构
    uint256 id;
    uint256 cashFlowID;
    string senderID;
    string receiverID;
    uint256 beforeTrans;
    uint256 afterTrans;
    uint256 cashNum;
    uint256 timestamp;

    constructor(
        uint256 _id,
        uint256 _cashFlowID,
        string memory _senderID,
        string memory _receiverID,
        uint256 _beforeTrans,
        uint256 _afterTrans,
        uint256 _cashNum
    ) {
        id = _id;
        cashFlowID = _cashFlowID;
        senderID = _senderID;
        receiverID = _receiverID;
        beforeTrans = _beforeTrans;
        afterTrans = _afterTrans;
        cashNum = _cashNum;
        timestamp = block.timestamp;
    }

    function getTransactionID() public view returns (uint256) {
        return id;
    }
}

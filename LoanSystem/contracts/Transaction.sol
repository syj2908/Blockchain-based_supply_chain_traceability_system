contract Transaction {
    //交易数据结构
    uint256 public id;
    uint256 cashFlowID;
    address senderID;
    address receiverID;
    uint256 beforeTrans;
    uint256 afterTrans;
    uint256 cashNum;
    string note;
    uint256 timestamp;

    constructor(
        uint256 _id,
        uint256 _cashFlowID,
        address _senderID,
        address _receiverID,
        uint256 _beforeTrans,
        uint256 _afterTrans,
        uint256 _cashNum,
        string memory _note
    ) {
        id = _id;
        cashFlowID = _cashFlowID;
        senderID = _senderID;
        receiverID = _receiverID;
        beforeTrans = _beforeTrans;
        afterTrans = _afterTrans;
        cashNum = _cashNum;
        note = _note;
        timestamp = block.timestamp;
    }

    function checkTransaction()
        public
        view
        returns (
            uint256,
            address,
            address,
            uint256,
            uint256,
            uint256,
            string memory,
            uint256
        )
    {
        return (
            cashFlowID,
            senderID,
            receiverID,
            beforeTrans,
            afterTrans,
            cashNum,
            note,
            timestamp
        );
    }
}

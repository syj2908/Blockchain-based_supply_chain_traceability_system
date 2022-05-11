contract Transaction {
    //交易数据结构
    uint256 public id; //交易ID
    uint256 cashFlowID; //关联资金流ID
    address senderID; //交易发起者ID
    address receiverID; //交易接收者ID
    uint256 beforeTrans; //交易前资金金额
    uint256 afterTrans; //交易后资金金额
    uint256 cashNum; //交易金额
    string note; //备注
    uint256 timestamp; //时间戳

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

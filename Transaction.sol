contract Transaction {
    //交易数据结构
    uint id;
    uint cashFlowID;
    string senderID;
    string receiverID;
    uint beforeTrans;
    uint afterTrans;
    int cashNum;
    uint timestamp;

    constructor(
        uint _id,
        uint _cashFlowID,
        string memory _senderID,
        string memory _receiverID,
        uint _beforeTrans,
        int _cashNum
    )
    {
        id=_id;
        cashFlowID=_cashFlowID;
        senderID=_senderID;
        receiverID=_receiverID;
        beforeTrans=_beforeTrans;
        afterTrans=uint(int(beforeTrans)-cashNum);
        cashNum=_cashNum;
        timestamp=block.timestamp;
    }
}
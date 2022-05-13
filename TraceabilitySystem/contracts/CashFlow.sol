contract CashFlow {
    //资金流数据结构
    uint256 public id; //资金流ID
    uint256 initBalance; //初始余额
    uint256 public currBalance; //当前余额
    uint256[] Transactions; //相关交易列表

    constructor(uint256 _id, uint256 cashNum) {
        id = _id;
        initBalance = cashNum;
        currBalance = cashNum;
    }

    function withdraw(uint256 cashNum) public returns (bool) {
        if (currBalance >= cashNum) {
            currBalance -= cashNum;
            return true;
        } else return false;
    }

    function attachTransaction(uint256 transactionID) public returns (bool) {
        Transactions.push(transactionID);
        return true;
    }

    function checkCashFlow()
        public
        view
        returns (
            uint256,
            uint256,
            uint256[] memory
        )
    {
        return (initBalance, currBalance, Transactions);
    }
}

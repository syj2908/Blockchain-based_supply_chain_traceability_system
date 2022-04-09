contract CashFlow {
    uint256 public id;
    uint256 initBalance;
    uint256 public currBalance;
    uint256[] Transactions;

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
}

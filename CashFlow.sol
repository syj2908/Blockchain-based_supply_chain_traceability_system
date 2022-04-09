contract CashFlow {
    uint public id;
    uint initBalance;
    uint currBalance;
    uint[] Transactions;

    constructor(
        uint _id,
        uint cashNum
    )
    {
        id=_id;
        initBalance=cashNum;
        currBalance=cashNum;
    }
}

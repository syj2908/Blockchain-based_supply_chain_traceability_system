contract Lender {
    //放贷者结构体
    address public id;
    string account;
    string passwd;
    string name;
    bool public valid = true;
    uint256[] cashFlows;

    constructor(
        address _id,
        string memory _account,
        string memory _passwd,
        string memory _name
    ) public {
        id = _id;
        account = _account;
        passwd = _passwd;
        name = _name;
    }

    function attachCashFlow(uint256 cashFlowID) public returns (bool) {
        cashFlows.push(cashFlowID);
        return true;
    }

    function getLenderInfo()
        public
        view
        returns (
            address,
            string memory,
            string memory,
            uint256[] memory
        )
    {
        return (id, account, name, cashFlows);
    }

    function deleteLender() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }
}

contract Lender {
    //放贷者结构体
    string id;
    string account;
    string passwd;
    string name;

    constructor(
        string memory _id,
        string memory _account,
        string memory _passwd,
        string memory _name
    ) {
        id = _id;
        account = _account;
        passwd = _passwd;
        name = _name;
    }

    function getLenderID() public view returns (string memory) {
        return id;
    }

    function getLenderInfo()
        public
        view
        returns (
            string memory,
            string memory,
            string memory
        )
    {
        return (id, account, name);
    }
}
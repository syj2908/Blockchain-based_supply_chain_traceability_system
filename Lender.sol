contract Lender {
    //放贷者结构体
    string id;
    string account;
    string passwd;
    string name;
    bool valid;

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
        valid = true;
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

    function deleteLender() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

    function isValid() public view returns (bool) {
        return valid;
    }
}

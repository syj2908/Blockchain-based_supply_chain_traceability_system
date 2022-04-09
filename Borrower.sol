contract Borrower {
    uint256 public id;
    string passwd;
    string name;
    uint256 reputation;
    bool public valid;

    constructor(
        uint256 _id,
        string memory _passwd,
        string memory _name,
        uint256 _reputation
    ) {
        id = _id;
        passwd = _passwd;
        name = _name;
        reputation = _reputation;
        valid = true;
    }
}

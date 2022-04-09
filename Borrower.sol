contract Borrower {
    uint256 public uId;
    string passwd;
    string name;
    uint256 reputation;

    constructor(
        uint256 _uId,
        string memory _passwd,
        string memory _name,
        uint256 _reputation
    ) {
        uId = _uId;
        passwd = _passwd;
        name = _name;
        reputation = _reputation;
    }
}
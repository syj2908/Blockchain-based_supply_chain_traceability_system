contract Manager {
    uint256 public uId;
    string passwd;

    constructor(uint256 _uId, string memory _passwd) {
        uId = _uId;
        passwd = _passwd;
    }
}
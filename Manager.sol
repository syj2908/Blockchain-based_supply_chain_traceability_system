contract Manager {
    uint256 public id;
    string passwd;

    constructor(uint256 _id, string memory _passwd) {
        id = _id;
        passwd = _passwd;
    }
}
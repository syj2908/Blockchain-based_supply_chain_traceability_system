contract Procedure {
    //物流数据结构
    uint256 public id;
    uint256 itemID;
    address master;
    string operation;
    uint256 timestamp;

    constructor(
        uint256 _id,
        uint256 _itemID,
        address _master,
        string memory _operation
    ) {
        id = _id;
        itemID = _itemID;
        master = _master;
        operation = _operation;
        timestamp = block.timestamp;
    }

    function checkProcedure()
        public
        view
        returns (
            uint256,
            address,
            string memory,
            uint256
        )
    {
        return (itemID, master, operation, timestamp);
    }
}

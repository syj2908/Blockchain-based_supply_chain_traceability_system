contract ItemFlow {
    //物品数据结构
    uint256 public id;
    string name;
    address master;
    string note;
    uint256[] procedures;

    constructor(
        uint256 _id,
        string memory _name,
        address _master,
        string memory _note
    ) {
        id = _id;
        name = _name;
        master = _master;
        note = _note;
    }

    function attachProcedure(uint256 procedureID) public returns (bool) {
        procedures.push(procedureID);
        return true;
    }

    function checkItemFlow()
        public
        view
        returns (
            string memory,
            address,
            string memory,
            uint256[] memory
        )
    {
        return (name, master, note, procedures);
    }
}

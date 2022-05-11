contract PartsFlow {
    //零部件数据结构
    uint256 public id; //零部件ID
    address createrID; //零部件生产商ID
    string name; //零部件名称
    string partsType; //零部件类型
    string batch; //零部件批次
    string note; //备注
    uint256[] procedures; //零部件关联的加工过程列表
    uint256[] formerparts; //组装成零部件的低级部件ID

    constructor(
        uint256 _id,
        address _createrID,
        string memory _name,
        string memory _partsType,
        string memory _batch,
        uint256[] memory _formerparts,
        string memory _note
    ) {
        id = _id;
        createrID = _createrID;
        name = _name;
        partsType = _partsType;
        batch = _batch;
        formerparts = _formerparts;
        note = _note;
    }

    function attachProcedure(uint256 procedureID) public returns (bool) {
        procedures.push(procedureID);
        return true;
    }

    function checkPartsFlow()
        public
        view
        returns (
            address,
            string memory,
            string memory,
            string memory,
            string memory,
            uint256[] memory,
            uint256[] memory
        )
    {
        return (
            createrID,
            name,
            partsType,
            batch,
            note,
            procedures,
            formerparts
        );
    }
}

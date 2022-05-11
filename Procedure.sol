enum ProcedureType {
    technical,
    assemble
}

contract Procedure {
    //加工过程数据结构
    uint256 public id; //加工过程ID
    uint256 partsID; //被加工零部件ID
    address processorID; //加工商ID
    ProcedureType procedureType; //加工类型
    string operation; //加工操作描述
    uint256 timestamp; //时间戳

    constructor(
        uint256 _id,
        uint256 _partsID,
        address _processorID,
        ProcedureType _procedureType,
        string memory _operation
    ) {
        id = _id;
        partsID = _partsID;
        processorID = _processorID;
        procedureType = _procedureType;
        operation = _operation;
        timestamp = block.timestamp;
    }

    function checkProcedure()
        public
        view
        returns (
            uint256,
            address,
            ProcedureType,
            string memory,
            uint256
        )
    {
        return (partsID, processorID, procedureType, operation, timestamp);
    }
}

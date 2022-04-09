pragma solidity ^0.8.7;

import "./Lender.sol";
import "./Borrower.sol";
import "./Manager.sol";
import "./CashFlow.sol";
import "./Transaction.sol";

contract LoanSystem {
    //借贷系统

    Lender[] public lenders;
    Borrower[] public borrowers;
    Manager[] public managers;
    CashFlow[] public cashFlows;
    Transaction[] public transactions;

    uint256[] IDarr = [0, 0, 0]; //用户id计数器
    uint256 cashFlowCount = 0; //资金流ID计数器
    uint256 TransactionCount = 0; //交易ID计数器

    function createLender(
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (string memory) {
        //创建一个放贷者并返回用户ID
        string memory id;
        id = generateID(0);
        Lender lender = new Lender(id, account, passwd, name);
        lenders.push(lender);
        return id;
    }

    // function createBorrower(string memory passwd) public returns (uint256) {}

    // function createManager(string memory passwd) public returns (uint256) {}

    function deleteLender(string memory id) public returns (bool) {
        //删除指定放贷者
        for (uint256 i = 0; i < lenders.length; i++) {
            if (
                keccak256(bytes(lenders[i].getLenderID())) ==
                keccak256(bytes(id))
            ) {
                return lenders[i].deleteLender();
            }
        }
    }

    function getLenderInfo(string memory id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory
        )
    {
        //返回放贷者信息(除密码)
        for (uint256 i = 0; i < lenders.length; i++) {
            if (
                keccak256(bytes(lenders[i].getLenderID())) ==
                keccak256(bytes(id))
            )
                if (lenders[i].isValid()) return lenders[i].getLenderInfo();
                else break;
        }
        return ("NotFound", "NotFound", "NotFound");
    }

    function getAllLenderInfo() public view returns (Lender[] memory) {
        //返回所有放贷者信息
        //功能未实现 待补充
        return lenders;
    }

    function createCashFlow(
        string memory lenderID,
        string memory borrowerID,
        uint256 cashNum
    ) public returns (bool) {
        //发起一条资金流
        CashFlow cashflow = new CashFlow(cashFlowCount, cashNum);
        cashFlows.push(cashflow);
        for (uint256 i = 0; i < lenders.length; i++) {
            if (
                keccak256(bytes(lenders[i].getLenderID())) ==
                keccak256(bytes(lenderID)) &&
                lenders[i].valid()
            ) lenders[i].attachCashFlow(cashflow.id());
        }
        //涉及借贷者部分 待补充
        //
        // for (uint256 i = 0; i < borrowers.length; i++) {
        //     if (
        //         keccak256(bytes(borrowers[i].getBorrowerID())) ==
        //         keccak256(bytes(borrowerID)) &&
        //         borrowers[i].isValid()
        //     ) borrowers[i].attachCashFlow(cashFlowCount);
        // }
        cashFlowCount++;
        return true;
    }

    //业务无关函数

    function strConcat(string memory _a, string memory _b)
        public
        pure
        returns (string memory)
    {
        //字符串拼接
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ret = new string(_ba.length + _bb.length);
        bytes memory bret = bytes(ret);
        uint256 k = 0;
        for (uint256 i = 0; i < _ba.length; i++) bret[k++] = _ba[i];
        for (uint256 i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        return string(ret);
    }

    function generateID(uint8 t) public returns (string memory) {
        //产生一个用户id 作为主键
        IDarr[t]++;
        uint256 rawID = IDarr[t] - 1;
        string memory strID;
        if (rawID == 0) strID = "0";
        else {
            uint256 cp = rawID;
            uint256 len = 0;
            while (cp != 0) {
                len++;
                cp /= 10;
            }
            bytes memory bstr = new bytes(len);
            while (rawID != 0) {
                len--;
                uint8 temp = (48 + uint8(rawID - (rawID / 10) * 10));
                bytes1 b1 = bytes1(temp);
                bstr[len] = b1;
                rawID /= 10;
            }
            strID = string(bstr);
        }
        string memory prefix;
        if (t == 0) prefix = "0";
        else if (t == 1) prefix = "1";
        else prefix = "2";
        return strConcat(prefix, strID);
    }
}

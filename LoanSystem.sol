pragma solidity ^0.8.7;

import "./Lender.sol";
import "./Borrower.sol";
import "./Manager.sol";
import "./SysFunc.sol";

contract LoanSystem {
    //借贷系统
    function createLender(
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (string memory) {
        //创建一个放贷者并返回用户ID
        string memory id = generateID(0);
        Lender tmp = new Lender(id, account, passwd, name);
        lenders.push(tmp);
        return id;
    }

    // function createBorrower(string memory passwd) public returns (uint256) {}

    // function createManager(string memory passwd) public returns (uint256) {}

    // function deleteLender() {}

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
            ) {
                return lenders[i].getLenderInfo();
            }
        }
    }

    function getAllLenderInfo() public view returns (Lender[] memory) {
        //返回所有放贷者信息
        return lenders;
    }
}

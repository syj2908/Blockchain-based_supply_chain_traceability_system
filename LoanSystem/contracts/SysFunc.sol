// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

import "./Lender.sol";
import "./Borrower.sol";
import "./Manager.sol";
import "./CashFlow.sol";
import "./Transaction.sol";
import "./ItemFlow.sol";
import "./Procedure.sol";

library SysFunc {
    event CreateLender(address id, string account, string name);
    event CreateBorrower(address id, string account, string name);
    event CreateManager(address id);
    event DeleteLender(address id, bool result);
    event DeleteBorrower(address id, bool result);
    event DeleteManager(address id, bool result);
    event CreateCashFlow(address from, address to, uint256 amount);
    event CreateTransaction(
        address from,
        address to,
        uint256 cashFlowID,
        uint256 amount
    );
    event CreateItemFlow(address master, string name);
    event CreateProcedure(uint256 itemID, address master, string operation);

    function createLender(
        Lender[] storage lenders,
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (bool) {
        address id = msg.sender;
        Lender lender = new Lender(id, account, passwd, name);
        lenders.push(lender);
        emit CreateLender(id, account, name);
        return true;
    }

    function createBorrower(
        Borrower[] storage borrowers,
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (bool) {
        address id = msg.sender;
        Borrower borrower = new Borrower(id, account, passwd, name);
        borrowers.push(borrower);
        emit CreateBorrower(id, account, name);
        return true;
    }

    function createManager(Manager[] storage managers, string memory passwd)
        public
        returns (bool)
    {
        address id = msg.sender;
        Manager manager = new Manager(id, passwd);
        managers.push(manager);
        emit CreateManager(id);
        return true;
    }

    function deleteLender(Lender[] storage lenders) public returns (bool) {
        address id = msg.sender;
        for (uint256 i = 0; i < lenders.length; i++) {
            if (lenders[i].id() == id) {
                bool result = lenders[i].deleteLender();
                emit DeleteLender(id, result);
                return result;
            }
        }
    }

    function deleteBorrower(Borrower[] storage borrowers)
        public
        returns (bool)
    {
        address id = msg.sender;
        for (uint256 i = 0; i < borrowers.length; i++) {
            if (borrowers[i].id() == id) {
                bool result = borrowers[i].deleteBorrower();
                emit DeleteBorrower(id, result);
                return result;
            }
        }
    }

    function deleteManager(Manager[] storage managers) public returns (bool) {
        address id = msg.sender;
        for (uint256 i = 0; i < managers.length; i++) {
            if (managers[i].id() == id) {
                bool result = managers[i].deleteManager();
                emit DeleteManager(id, result);
                return result;
            }
        }
    }

    function getLenderInfo(Lender[] storage lenders)
        public
        view
        returns (
            address,
            string memory,
            string memory,
            uint256[] memory
        )
    {
        address id = msg.sender;
        for (uint256 i = 0; i < lenders.length; i++) {
            if (lenders[i].id() == id)
                if (lenders[i].valid()) return lenders[i].getLenderInfo();
                else break;
        }
        address addr = 0x0000000000000000000000000000000000000000;
        uint256[] memory arr;
        return (addr, "NotFound", "NotFound", arr);
    }

    function getBorrowerInfo(Borrower[] storage borrowers)
        public
        view
        returns (
            address,
            string memory,
            string memory,
            uint256,
            uint256,
            uint256[] memory
        )
    {
        address id = msg.sender;
        for (uint256 i = 0; i < borrowers.length; i++) {
            if (borrowers[i].id() == id)
                if (borrowers[i].valid()) return borrowers[i].getBorrowerInfo();
                else break;
        }
        address addr = 0x0000000000000000000000000000000000000000;
        uint256[] memory arr;
        return (
            addr,
            "NotFound",
            "NotFound",
            type(uint256).max,
            type(uint256).max,
            arr
        );
    }

    function createItemFlow(
        string memory name,
        string memory note,
        uint256 itemFlowCount,
        ItemFlow[] storage itemflows
    ) public returns (bool) {
        ItemFlow itemflow = new ItemFlow(itemFlowCount, name, msg.sender, note);
        itemflows.push(itemflow);
        emit CreateItemFlow(msg.sender, name);
        return true;
    }

    function createProcedure(
        uint256 itemID,
        string memory operation,
        uint256 procedureCount,
        Procedure[] storage procedures
    ) public returns (bool) {
        //物品流变动
        Procedure procedure = new Procedure(
            procedureCount,
            itemID,
            msg.sender,
            operation
        );
        procedures.push(procedure);
        emit CreateProcedure(itemID, msg.sender, operation);
        return true;
    }
}

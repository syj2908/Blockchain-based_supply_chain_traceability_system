pragma solidity ^0.8.7;

import "./Lender.sol";
import "./Borrower.sol";
import "./Manager.sol";
import "./CashFlow.sol";
import "./Transaction.sol";
import "./SysFunc.sol";

contract LoanSystem {
    //借贷系统

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

    Lender[] lenders;
    Borrower[] borrowers;
    Manager[] managers;
    CashFlow[] cashFlows;
    Transaction[] transactions;

    uint256 cashFlowCount = 0; //资金流ID计数器
    uint256 TransactionCount = 0; //交易ID计数器

    function createLender(
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (address) {
        //创建一个放贷者并返回用户ID
        address id = msg.sender;
        Lender lender = new Lender(id, account, passwd, name);
        lenders.push(lender);
        emit CreateLender(id, account, name);
        return id;
    }

    function createBorrower(
        string memory account,
        string memory passwd,
        string memory name
    ) public returns (address) {
        //创建一个借贷者并返回用户ID
        address id = msg.sender;
        Borrower borrower = new Borrower(id, account, passwd, name);
        borrowers.push(borrower);
        emit CreateBorrower(id, account, name);
        return id;
    }

    function createManager(string memory passwd) public returns (address) {
        address id = msg.sender;
        Manager manager = new Manager(id, passwd);
        managers.push(manager);
        emit CreateManager(id);
        return id;
    }

    function deleteLender() public returns (bool) {
        //删除指定放贷者
        address id = msg.sender;
        for (uint256 i = 0; i < lenders.length; i++) {
            if (lenders[i].id() == id) {
                bool result = lenders[i].deleteLender();
                emit DeleteLender(id, result);
                return result;
            }
        }
    }

    function deleteBorrower() public returns (bool) {
        //删除指定借贷者
        address id = msg.sender;
        for (uint256 i = 0; i < borrowers.length; i++) {
            if (borrowers[i].id() == id) {
                bool result = borrowers[i].deleteBorrower();
                emit DeleteBorrower(id, result);
                return result;
            }
        }
    }

    function deleteManager() public returns (bool) {
        //删除指定管理员
        address id = msg.sender;
        for (uint256 i = 0; i < lenders.length; i++) {
            if (managers[i].id() == id) {
                bool result = managers[i].deleteManager();
                emit DeleteManager(id, result);
                return result;
            }
        }
    }

    function getLenderInfo()
        public
        view
        returns (
            address,
            string memory,
            string memory,
            uint256[] memory
        )
    {
        //返回放贷者信息(除密码)
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

    function getBorrowerInfo()
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
        //返回借贷者信息(除密码)
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

    // function getAllLenderInfo() public view returns (Lender[] memory) {
    //     //返回所有放贷者信息
    //     //功能未实现 待补充
    // }

    function createCashFlow(address borrowerID, uint256 cashNum)
        public
        returns (uint256)
    {
        //发起一条资金流
        CashFlow cashflow = new CashFlow(cashFlowCount, cashNum);
        cashFlows.push(cashflow);
        for (uint256 i = 0; i < lenders.length; i++) {
            if (lenders[i].id() == msg.sender && lenders[i].valid())
                lenders[i].attachCashFlow(cashflow.id());
        }
        for (uint256 i = 0; i < borrowers.length; i++) {
            if (borrowers[i].id() == borrowerID && borrowers[i].valid())
                borrowers[i].attachCashFlow(cashFlowCount);
        }
        emit CreateCashFlow(msg.sender, borrowerID, cashNum);
        cashFlowCount++;
        return cashflow.id();
    }

    function createTransaction(
        uint256 cashFlowID,
        address receiverID,
        uint256 cashNum,
        string memory note
    ) public returns (uint256) {
        //发起一次交易
        uint256 prevCash = cashFlows[cashFlowID].currBalance();
        if (cashFlows[cashFlowID].withdraw(cashNum)) {
            Transaction transaction = new Transaction(
                TransactionCount,
                cashFlowID,
                msg.sender,
                receiverID,
                prevCash,
                cashFlows[cashFlowID].currBalance(),
                cashNum,
                note
            );
            transactions.push(transaction);
            TransactionCount++;
            cashFlows[cashFlowID].attachTransaction(transaction.id());
            emit CreateTransaction(msg.sender, receiverID, cashFlowID, cashNum);
            return transaction.id();
        } else return type(uint256).max;
    }

    function checkCashFlow(uint256 cashflowID)
        public
        view
        returns (
            uint256,
            uint256,
            uint256[] memory
        )
    {
        //查看资金流的详细信息
        return cashFlows[cashflowID].checkCashFlow();
    }

    function checkTransaction(uint256 transactionID)
        public
        view
        returns (
            uint256,
            address,
            address,
            uint256,
            uint256,
            uint256,
            string memory,
            uint256
        )
    {
        //查看交易的详细信息
        return transactions[transactionID].checkTransaction();
    }
}

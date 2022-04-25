// SPDX-License-Identifier: SimPL-2.0
pragma solidity ^0.8.7;

import "./Lender.sol";
import "./Borrower.sol";
import "./Manager.sol";
import "./CashFlow.sol";
import "./Transaction.sol";
import "./ItemFlow.sol";
import "./Procedure.sol";
import "./SysFunc.sol";

contract LoanSystem {
    //借贷系统

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
    ItemFlow[] itemflows;
    Procedure[] procedures;

    uint256 cashFlowCount = 0; //资金流ID计数器
    uint256 TransactionCount = 0; //交易ID计数器
    uint256 itemFlowCount = 0; //物品流ID计数器
    uint256 procedureCount = 0; //过程ID计数器

    function createLender(
        string memory account,
        string memory passwd,
        string memory name
    ) public {
        //创建一个放贷者
        require(SysFunc.createLender(lenders, account, passwd, name));
    }

    function createBorrower(
        string memory account,
        string memory passwd,
        string memory name
    ) public {
        //创建一个借贷者
        require(SysFunc.createBorrower(borrowers, account, passwd, name));
    }

    function createManager(string memory passwd) public {
        //创建一个管理员
        require(SysFunc.createManager(managers, passwd));
    }

    function deleteLender() public {
        //删除指定放贷者
        require(SysFunc.deleteLender(lenders));
    }

    function deleteBorrower() public {
        //删除指定借贷者
        require(SysFunc.deleteBorrower(borrowers));
    }

    function deleteManager() public {
        //删除指定管理员
        require(SysFunc.deleteManager(managers));
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
        return SysFunc.getLenderInfo(lenders);
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
        return SysFunc.getBorrowerInfo(borrowers);
    }

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

    function createItemFlow(string memory name, string memory note)
        public
        returns (uint256)
    {
        //物品上链
        require(SysFunc.createItemFlow(name, note, itemFlowCount, itemflows));
        itemFlowCount++;
        return itemFlowCount - 1;
    }

    function createProcedure(uint256 itemID, string memory operation) public {
        //物品流变动
        require(
            SysFunc.createProcedure(
                itemID,
                operation,
                procedureCount,
                procedures
            )
        );
        itemflows[itemID].attachProcedure(procedureCount);
        procedureCount++;
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

    function checkItemFlow(uint256 itemID)
        public
        view
        returns (
            string memory,
            address,
            string memory,
            uint256[] memory
        )
    {
        return itemflows[itemID].checkItemFlow();
    }

    function checkProcedure(uint256 procedureID)
        public
        view
        returns (
            uint256,
            address,
            string memory,
            uint256
        )
    {
        return procedures[procedureID].checkProcedure();
    }
}

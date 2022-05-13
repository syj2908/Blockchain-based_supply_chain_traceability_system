pragma solidity ^0.8.7;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TraceabilitySystem.sol";

contract TestTraceabilitySystem {
    TraceabilitySystem traceabilitySystem = TraceabilitySystem(DeployedAddresses.TraceabilitySystem());
    string lenderID;
    string borrowerID;
    uint256 cashflowID;
    uint256 cashNum = 1000;
    uint256[] transactionlist;

    function testLenderCreate() public {
        lenderID = traceabilitySystem.createLender("syj", "123", "XJTU");
        bytes memory id = bytes(lenderID);
        Assert.equal(id[0], "0", "Create Lender failed.");
    }

    function testBorrowerCreate() public {
        borrowerID = traceabilitySystem.createBorrower("jys", "456", "XJTU");
        bytes memory id = bytes(borrowerID);
        Assert.equal(id[0], "1", "Create Borrower failed.");
    }

    function testCreateCashFlow() public {
        cashflowID = traceabilitySystem.createCashFlow(lenderID, borrowerID, cashNum);
        Assert.notEqual(
            cashflowID,
            type(uint256).max,
            "Cashflow create failed."
        );
    }

    function testCheckCashFlow() public {
        uint256 initBalance;
        (initBalance, , ) = traceabilitySystem.checkCashFlow(cashflowID);
        Assert.equal(initBalance, cashNum, "Cashflow check failed.");
    }

    function testCreateTransaction() public {
        uint256 transactionID = traceabilitySystem.createTransaction(
            cashflowID,
            borrowerID,
            "111",
            829,
            "First transaction."
        );
        Assert.notEqual(
            transactionID,
            type(uint256).max,
            "Create transaction failed."
        );
        transactionlist.push(transactionID);
    }

    function testDeleteLender() public {
        bool res = traceabilitySystem.deleteLender(lenderID);
        Assert.isTrue(res, "Delete Lender failed.");
    }

    function testDeleteBorrower() public {
        bool res = traceabilitySystem.deleteBorrower(borrowerID);
        Assert.isTrue(res, "Delete Borrower failed.");
    }
}

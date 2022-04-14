var Borrower = artifacts.require("Borrower");
var Lender = artifacts.require("Lender");
var Manager = artifacts.require("Manager");
var CashFlow = artifacts.require("CashFlow");
var Transaction = artifacts.require("Transaction");
var LoanSystem = artifacts.require("LoanSystem");

module.exports = function (deployer) {
    //deployer.deploy(Borrower);
    //deployer.deploy(Lender);
    //deployer.deploy(Manager);
    //deployer.deploy(CashFlow);
    //deployer.deploy(Transaction);
    deployer.deploy(LoanSystem);
};

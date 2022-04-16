var LoanSystem = artifacts.require("LoanSystem");
var SysFunc=artifacts.require("SysFunc");

module.exports = function (deployer) {
    deployer.deploy(SysFunc);
    deployer.link(SysFunc,LoanSystem);
    deployer.deploy(LoanSystem);
};

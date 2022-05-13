var TraceabilitySystem = artifacts.require("TraceabilitySystem");
var SysFunc=artifacts.require("SysFunc");

module.exports = function (deployer) {
    deployer.deploy(SysFunc);
    deployer.link(SysFunc,TraceabilitySystem);
    deployer.deploy(TraceabilitySystem);
};

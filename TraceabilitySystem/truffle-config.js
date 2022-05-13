const path = require("path");

module.exports = {
  contracts_build_directory: path.join(__dirname, "/client/src/contracts"),
  compilers: {
    solc: {
      version: "^0.8.7",
    }
  },
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    }
  }
};

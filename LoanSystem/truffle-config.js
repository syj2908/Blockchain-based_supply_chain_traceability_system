module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
 compilers: {
   solc: {
     version: "^0.8.11",
    }
 },
 networks: {
  development: {
    host: "127.0.0.1",
    port: 8545,
    network_id: "*" // Match any network id
  },
  develop: {
    port: 8545
  }
 }
};

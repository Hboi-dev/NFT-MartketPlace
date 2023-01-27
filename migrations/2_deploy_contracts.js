const HboiBirdz = artifacts.require("HboiBirdz"); // grab the complied code from HboiBirdz and store in a new
//variable called HboiBirdz

module.exports = function (deployer) {
    deployer.deploy(HboiBirdz); // deploy our contract to the blockchain
  };

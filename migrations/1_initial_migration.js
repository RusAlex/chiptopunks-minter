const Migrations = artifacts.require("Migrations");
const ChiptoPunks = artifacts.require("ChiptoPunks");
const Contract = artifacts.require("Contract");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ChiptoPunks);
  deployer.deploy(Contract);
};

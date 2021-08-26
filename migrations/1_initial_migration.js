const Migrations = artifacts.require("Migrations");
const ChiptoPunks = artifacts.require("ChiptoPunks");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ChiptoPunks);
};

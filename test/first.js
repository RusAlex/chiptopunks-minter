const ChiptoPunks = artifacts.require("ChiptoPunks");
const Contract = artifacts.require("Contract");

contract("test", accounts => {
  it("should work", () =>
    ChiptoPunks.deployed().then(instance =>
      Contract.deployed()
        .then(contract =>
          contract.buyChips(instance.address, {
            value: web3.utils.toWei("5", "ether")
          })
        )
        .then(console.log)
    ));
});

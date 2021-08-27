const ChiptoPunks = artifacts.require("ChiptoPunks");
const Contract = artifacts.require("Contract");

contract("test", accounts => {
  it("should work", () =>
    ChiptoPunks.deployed().then(instance =>
      Contract.deployed().then(contract =>
        contract
          .buyChips(instance.address, {
            value: web3.utils.toWei("5", "ether")
          })
          .then(() => instance.balanceOf(contract.address))
          .then(bal => assert.equal(bal, 3))
          .then(() => contract.reclaimNftToken(ChiptoPunks.address, 1))
          .then(() => instance.balanceOf(contract.address))
          .then(bal => assert.equal(bal, 2))
      )
    ));
});

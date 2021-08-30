const ChiptoPunks = artifacts.require("ChiptoPunks");
const Contract = artifacts.require("Contract");

// chipPrice = 0.002 ether;
contract("test", accounts => {
  it("should work", () =>
    ChiptoPunks.deployed().then(instance =>
      Contract.deployed().then(contract =>
        contract
          .mintWithNumberPerCall(instance.address, 2, 3, {
            value: web3.utils.toWei("0.012", "ether")
          })
          .then(() => instance.balanceOf(contract.address))
          .then(bal => assert.equal(bal, 6))
          .then(() => contract.reclaimNftToken(ChiptoPunks.address, 0))
          .then(() => instance.balanceOf(contract.address))
          .then(bal => assert.equal(bal, 5))
      )
    ));
});

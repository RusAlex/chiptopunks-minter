const ChiptoPunks = artifacts.require("ChiptoPunks");

contract("test", () => {
  it("should work", () =>
    ChiptoPunks.deployed().then(instance => assert(true)));
});

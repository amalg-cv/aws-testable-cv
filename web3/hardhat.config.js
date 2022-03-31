require("@nomiclabs/hardhat-waffle");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: "0.8.4",
  networks: {
    hardhat: {},
    ganache: {
      url: "http://127.0.0.1:7545",
      account: [
        "0x0b4d12b20d8aa182cc727c47147c91f01a9f259077ab3122ed9a9665130a9cd0"
      ]
    },
    // rinkeby: {},
    // ropsten: {}
  },
  // etherscan:{
  //   apiKey: ""
  // }
};

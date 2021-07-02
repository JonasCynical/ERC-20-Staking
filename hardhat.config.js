require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  solidity: "0.8.0",
  networks: {
    HSC: {
      url: `https://http-mainnet.hoosmartchain.com`,
      accounts: [`5492aae1b7ea2953f0e833a2e5721c8df24d3b3cecaf50f7c60aa8007dc5b97d`]
    }
  }
};

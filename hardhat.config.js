require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");  

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

//  {
//   chainId?: number;
//   from?: string;
//   gas: "auto" | number;
//   gasPrice: "auto" | number;
//   gasMultiplier: number;
//   url: string;
//   timeout: number;
//   httpHeaders: { [name: string]: string };
//   accounts: HttpNetworkAccountsConfig;
// }


 module.exports = {
  solidity: "0.8.0",
  networks: {
    HSC: {
      url: `https://http-mainnet.hoosmartchain.com`,
      accounts: [`5492aae1b7ea2953f0e833a2e5721c8df24d3b3cecaf50f7c60aa8007dc5b97d`],
      gas: "auto",
      gasPrice: "auto",
      gasMultiplier: 1,
      timeout: 300000,
      //httpHeaders: { }
    },
    Rinkeby: {
      url: `https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161`,
      accounts: [`5492aae1b7ea2953f0e833a2e5721c8df24d3b3cecaf50f7c60aa8007dc5b97d`]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    // HSC API
    // apiKey: "XKWPGKWB5DWQTKDT5CV8FAQFTXEWC4XQVY"
    apiKey: "YUEHH6C9XZ3F9CQU3XCJSEMR4JY8VRFKN5"
  }
};

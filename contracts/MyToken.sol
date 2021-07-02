// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract MyToken is ERC20PresetMinterPauser {

    address public owner;

    constructor(
        uint256 initialSupply,
        string memory name,
        string memory symbol
        ) ERC20PresetMinterPauser(name, symbol) {
        _mint(msg.sender, initialSupply);
        owner = msg.sender;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./DappToken.sol";
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract TokenFarm {		
	string public name = "Dapp Token Farm";
	address public owner;
	DappToken public dappToken;
	address[] public stakers;
	uint public startBlock;
	// uint public oneYear = 2356364
	// for testing we use below
	uint public oneYear = 1200;
	mapping(address => uint) public stakingBalance;
	mapping(address => uint) public rewardsBalance;
	mapping(address => uint) public blockTime;
	mapping(address => bool) public hasStaked;
	mapping(address => bool) public isStaking;
	mapping(address => uint) public stakingTime;
	mapping(address => uint) public withdrawTime;


	constructor(DappToken _dappToken, uint _startBlock) public {
		dappToken = _dappToken;
		startBlock = _startBlock;
		owner = msg.sender;
	}

	/* Stakes Tokens (Deposit): An investor will deposit the DApp Tokens into the smart contracts
	to starting earning rewards.
		
	Core Thing: Transfer the Dapp Token tokens from the investor's wallet to this smart contract. */
	function stakeTokens(uint _amount) public {				
		// transfer Mock DApp tokens to this contract for staking
		dappToken.transferFrom(msg.sender, address(this), _amount);

		// update staking balance
		stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

		// update reward balance
		if(rewardsBalance[msg.sender] == 0) {
			uint balance = stakingBalance[msg.sender];
			uint propotion = (block.number - startBlock)/4;
			uint rewards = balance * propotion;
			rewardsBalance[msg.sender] == rewards;
			blockTime[msg.sender] == block.number;
		}
		else{
			uint balance = stakingBalance[msg.sender];
			uint propotion = (block.number - blockTime[msg.sender])/4;
			uint rewards = balance * propotion;
			rewardsBalance[msg.sender] == rewardsBalance[msg.sender] + rewards;
			blockTime[msg.sender] == block.number;
		}	

		// add user to stakers array *only* if they haven't staked already
		if(!hasStaked[msg.sender]) {
			stakers.push(msg.sender);
		}

		// update stakng status
		isStaking[msg.sender] = true;
		hasStaked[msg.sender] = true;
	}

	// Unstaking Tokens (Withdraw): Withdraw money from DApp.
	function unstakeTokens(uint _amount) public {
		// fetch staking balance
		uint balance = stakingBalance[msg.sender];

		// require amount greter than 0
		require(balance >= _amount, "withdraw amount cannot exceed deposit amount");

		// transfer Mock Dapp tokens to this contract for staking
		dappToken.transfer(msg.sender, _amount);

		// reset staking balance
		stakingBalance[msg.sender] = stakingBalance[msg.sender] - _amount;	

		// update staking status

		if(stakingBalance[msg.sender] == 0){
			isStaking[msg.sender] = false;
		}
	}

	/* Issuing Tokens: Earning interest which is issuing tokens for people who stake them.

	Core Thing: Distribute DApp tokens as interes and also allow the investor to unstake their tokens
	from the app so give them interest using the app. */
	function claimRewards() public {

    	require(block.number >= startBlock, "rewards claim have not been started yet");

		if(rewardsBalance[msg.sender] > 0) {
			uint balance = stakingBalance[msg.sender];
			uint propotion = (block.number - blockTime[msg.sender])/4;
			uint rewards = balance * propotion;
			rewardsBalance[msg.sender] == rewards;
			blockTime[msg.sender] == block.number;
		}	
	}

	function getStakedBalance(address _staker) public view returns (uint){
		return stakingBalance[_staker];
	}

	function getBlockNumber() public view returns(uint) {
		return block.number;
	}
}


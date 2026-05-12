// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A staking contract for MyNFT holders
contract MyNFTStaking {

    // Owner of the staking contract
    address public owner;

    // Tracks staked NFTs per wallet
    mapping(address => uint256[]) public stakedTokens;

    // Tracks which tokens are staked
    mapping(uint256 => bool) public isStaked;

    // Tracks who staked each token
    mapping(uint256 => address) public stakedBy;

    // Tracks when each token was staked
    mapping(uint256 => uint256) public stakedAt;

    // Events
    event NFTStaked(address indexed staker, uint256 tokenId);
    event NFTUnstaked(address indexed staker, uint256 tokenId);

    // Sets the owner on deployment
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Stake an NFT by token ID
    function stake(uint256 tokenId) public {
        require(!isStaked[tokenId], "Token already staked");
        stakedTokens[msg.sender].push(tokenId);
        isStaked[tokenId] = true;
        stakedBy[tokenId] = msg.sender;
        stakedAt[tokenId] = block.timestamp;
        emit NFTStaked(msg.sender, tokenId);
    }

    // Unstake an NFT by token ID
    function unstake(uint256 tokenId) public {
        require(isStaked[tokenId], "Token not staked");
        require(stakedBy[tokenId] == msg.sender, "Not the staker");
        isStaked[tokenId] = false;
        stakedBy[tokenId] = address(0);
        stakedAt[tokenId] = 0;
        emit NFTUnstaked(msg.sender, tokenId);
    }

    // Returns all staked tokens for a wallet
    function getStakedTokens(address _address) public view returns (uint256[] memory) {
        return stakedTokens[_address];
    }

    // Returns how long a token has been staked in seconds
    function stakedDuration(uint256 tokenId) public view returns (uint256) {
        require(isStaked[tokenId], "Token not staked");
        return block.timestamp - stakedAt[tokenId];
    }
}

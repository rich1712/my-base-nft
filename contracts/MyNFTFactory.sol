// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A factory contract that tracks all deployed MyNFT contracts
contract MyNFTFactory {

    // Owner of the factory
    address public owner;

    // List of all deployed contract addresses
    address[] public deployedContracts;

    // Mapping to check if an address is a deployed contract
    mapping(address => bool) public isDeployed;

    // Events
    event ContractDeployed(address indexed contractAddress, address indexed deployer);

    // Sets the factory owner on deployment
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Register a deployed contract address
    function registerContract(address _contractAddress) public onlyOwner {
        require(!isDeployed[_contractAddress], "Already registered");
        deployedContracts.push(_contractAddress);
        isDeployed[_contractAddress] = true;
        emit ContractDeployed(_contractAddress, msg.sender);
    }

    // Returns all deployed contract addresses
    function getDeployedContracts() public view returns (address[] memory) {
        return deployedContracts;
    }

    // Returns total number of deployed contracts
    function totalDeployed() public view returns (uint256) {
        return deployedContracts.length;
    }
}

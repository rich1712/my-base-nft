// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A helper contract to manage NFT airdrops
contract MyNFTAirdrop {

    // Owner of the airdrop contract
    address public owner;

    // Tracks addresses that have received an airdrop
    mapping(address => bool) public hasReceivedAirdrop;

    // List of all airdrop recipients
    address[] public recipients;

    // Events
    event AirdropSent(address indexed recipient);
    event AirdropListUpdated(address indexed recipient, bool status);

    // Sets the owner on deployment
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Add an address to the airdrop list
    function addRecipient(address _recipient) public onlyOwner {
        require(!hasReceivedAirdrop[_recipient], "Already on airdrop list");
        recipients.push(_recipient);
        emit AirdropListUpdated(_recipient, true);
    }

    // Add multiple addresses to the airdrop list
    function addRecipients(address[] calldata _recipients) public onlyOwner {
        for (uint256 i = 0; i < _recipients.length; i++) {
            if (!hasReceivedAirdrop[_recipients[i]]) {
                recipients.push(_recipients[i]);
                emit AirdropListUpdated(_recipients[i], true);
            }
        }
    }

    // Mark an address as having received the airdrop
    function markAirdropSent(address _recipient) public onlyOwner {
        require(!hasReceivedAirdrop[_recipient], "Already received airdrop");
        hasReceivedAirdrop[_recipient] = true;
        emit AirdropSent(_recipient);
    }

    // Returns all airdrop recipients
    function getRecipients() public view returns (address[] memory) {
        return recipients;
    }

    // Returns total number of recipients
    function totalRecipients() public view returns (uint256) {
        return recipients.length;
    }

    // Check if an address is on the airdrop list
    function isRecipient(address _address) public view returns (bool) {
        return hasReceivedAirdrop[_address];
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin ERC721 and Ownable contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// MyNFT is a simple NFT collection deployed on Base
contract MyNFT is ERC721, Ownable {
    
    // Tracks the total number of NFTs minted
    uint256 public tokenCounter;

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Mints a new NFT to the specified address
    // Only the contract owner can call this
    function mint(address to) public onlyOwner {
        _safeMint(to, tokenCounter);
        tokenCounter++;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin ERC721 and Ownable contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// MyNFT is a simple NFT collection deployed on Base
contract MyNFT is ERC721, Ownable {

    // Tracks the total number of NFTs minted
    uint256 public tokenCounter;

    // Maximum number of NFTs that can ever be minted
    uint256 public maxSupply = 100;

    // Price to mint one NFT
    uint256 public mintPrice = 0.01 ether;

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Mints a new NFT to the specified address
    // Anyone can mint by paying the mint price
    function mint(address to) public payable {
        require(tokenCounter < maxSupply, "Max supply reached");
        require(msg.value >= mintPrice, "Not enough ETH sent");
        _safeMint(to, tokenCounter);
        tokenCounter++;
    }
}

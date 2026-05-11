// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin ERC721, Ownable and Pausable contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

// MyNFT is a simple NFT collection deployed on Base
contract MyNFT is ERC721, Ownable, Pausable {

    // Tracks the total number of NFTs minted
    uint256 public tokenCounter;

    // Maximum number of NFTs that can ever be minted
    uint256 public maxSupply = 100;

    // Price to mint one NFT
    uint256 public mintPrice = 0.01 ether;

    // Base URI for NFT metadata
    string public baseURI;

    // Whitelist mapping
    mapping(address => bool) public whitelist;

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Allows owner to add address to whitelist
    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] = true;
    }

    // Allows owner to remove address from whitelist
    function removeFromWhitelist(address _address) public onlyOwner {
        whitelist[_address] = false;
    }

    // Allows owner to pause minting
    function pause() public onlyOwner {
        _pause();
    }

    // Allows owner to unpause minting
    function unpause() public onlyOwner {
        _unpause();
    }

    // Allows owner to set the base metadata URI
    function setBaseURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }

    // Returns the metadata URI for a given token
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return string(abi.encodePacked(baseURI,

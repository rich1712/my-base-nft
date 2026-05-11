// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin ERC721, Ownable and Pausable contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// MyNFT is a simple NFT collection deployed on Base
contract MyNFT is ERC721, Ownable, Pausable {

    // Tracks the total number of NFTs minted
    uint256 public tokenCounter;

    // Maximum number of NFTs that can ever be minted
    uint256 public maxSupply = 100;

    // Price to mint one NFT
    uint256 public mintPrice = 0.01 ether;

    // Max NFTs per wallet
    uint256 public maxPerWallet = 3;

    // Base URI for NFT metadata
    string public baseURI;

    // Whitelist mapping
    mapping(address => bool) public whitelist;

    // Tracks how many NFTs each wallet has minted
    mapping(address => uint256) public mintedPerWallet;

    // Events
    event NFTMinted(address indexed to, uint256 tokenId);
    event Withdrawn(address indexed owner, uint256 amount);
    event WhitelistUpdated(address indexed account, bool status);

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Allows owner to add address to whitelist
    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] =

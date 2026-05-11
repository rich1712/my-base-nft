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

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
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
        return string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".json"));
    }

    // Mints a new NFT to the specified address
    // Anyone can mint by paying the mint price
    function mint(address to) public payable whenNotPaused {
        require(tokenCounter < maxSupply, "Max supply reached");
        require(msg.value >= mintPrice, "Not enough ETH sent");
        _safeMint(to, tokenCounter);
        tokenCounter++;
    }

    // Allows owner to withdraw all ETH from contract
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");
        payable(owner()).transfer(balance);
    }
}

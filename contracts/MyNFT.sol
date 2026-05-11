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

    // Price to mint one NFT during public sale
    uint256 public mintPrice = 0.01 ether;

    // Price to mint one NFT during presale
    uint256 public presalePrice = 0.005 ether;

    // Max NFTs per wallet
    uint256 public maxPerWallet = 3;

    // Max NFTs per whitelisted wallet
    uint256 public maxPerWhitelist = 5;

    // Presale active flag
    bool public presaleActive = false;

    // Public sale active flag
    bool public publicSaleActive = false;

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
    event MintPriceUpdated(uint256 newPrice);
    event MaxPerWalletUpdated(uint256 newMax);
    event MaxPerWhitelistUpdated(uint256 newMax);
    event PresaleStatusUpdated(bool status);
    event PublicSaleStatusUpdated(bool status);

    // Sets the NFT name, symbol and owner on deployment
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Allows owner to add address to whitelist
    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] = true;
        emit WhitelistUpdated(_address, true);
    }

    // Allows owner to remove address from whitelist
    function removeFromWhitelist(address _address) public onlyOwner {
        whitelist[_address] = false;
        emit WhitelistUpdated(_address, false);
    }

    // Allows owner to toggle presale on or off
    function setPresaleActive(bool _status) public onlyOwner {
        presaleActive = _status;
        emit PresaleStatusUpdated(_status);
    }

    // Allows owner to toggle public sale on or off
    function setPublicSaleActive(bool _status) public onlyOwner {
        publicSaleActive = _status;
        emit PublicSaleStatusUpdated(_status);
    }

    // Allows owner to pause minting
    function pause() public onlyOwner {
        _pause();
    }

    // Allows owner to unpause minting
    function unpause() public onlyOwner {
        _unpause();
    }

    // Allows owner to mint for free
    function ownerMint(address to) public onlyOwner {
        require(tokenCounter < maxSupply, "Max supply reached");
        _safeMint(to, tokenCounter);
        emit NFTMinted(to, tokenCounter);
        tokenCounter++;
    }

    // Allows owner to gift NFTs to multiple addresses at once
    function giftNFT(address[] calldata recipients) public onlyOwner {
        require(tokenCounter + recipients.length <= maxSupply, "Would exceed max supply");
        for (uint256 i = 0; i < recipients.length; i++) {
            _safeMint(recipients[i], tokenCounter);
            emit NFTMinted(recipients[i], tokenCounter);
            tokenCounter++;
        }
    }

    // Allows owner to update the mint price
    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
        emit MintPriceUpdated(_mintPrice);
    }

    // Allows owner to update the max mints per wallet
    function setMaxPerWallet(uint256 _maxPerWallet) public onlyOwner {
        maxPerWallet = _maxPerWallet;
        emit MaxPerWalletUpdated(_maxPerWallet);
    }

    // Allows owner to update the max mints per whitelisted wallet
    function setMaxPerWhitelist(uint256 _maxPerWhitelist) public onlyOwner {
        maxPerWhitelist = _maxPerWhitelist;
        emit MaxPerWhitelistUpdated(_maxPerWhitelist);
    }

    // Allows owner to set the base metadata URI
    function setBaseURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }

    // Returns the metadata URI for a given token
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".json"));
    }

    // Returns the total number of NFTs currently in circulation
    function totalSupply() public view returns (uint256) {
        return tokenCounter;
    }

    // Returns the remaining number of NFTs available to mint
    function remainingSupply() public view returns (uint256) {
        return maxSupply - tokenCounter;
    }

    // Returns the contract ETH balance
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Returns how many NFTs a specific wallet has minted
    function walletMintCount(address _address) public view returns (uint256) {
        return mintedPerWallet[_address];
    }

    // Presale mint for whitelisted addresses at discounted price
    function presaleMint(address to) public payable whenNotPaused {
        require(presaleActive, "Presale is not active");
        require(whitelist[msg.sender], "Not whitelisted");
        require(tokenCounter < maxSupply, "Max supply reached");
        require(mintedPerWallet[msg.sender] < maxPerWhitelist, "Whitelist mint limit reached");
        require(msg.value >= presalePrice, "Not enough ETH sent");
        _safeMint(to, tokenCounter);
        emit NFTMinted(to, tokenCounter);
        mintedPerWallet[msg.sender]++;
        tokenCounter++;
    }

    // Public mint for everyone at full price
    function mint(address to) public payable whenNotPaused {
        require(publicSaleActive, "Public sale is not active");
        require(tokenCounter < maxSupply, "Max supply reached");
        require(mintedPerWallet[msg.sender] < maxPerWallet, "Max per wallet reached");
        require(msg.value >= mintPrice, "Not enough ETH sent");
        _safeMint(to, tokenCounter);
        emit NFTMinted(to, tokenCounter);
        mintedPerWallet[msg.sender]++;
        tokenCounter++;
    }

    // Allows token owner to burn their NFT
    function burn(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Not the token owner");
        _burn(tokenId);
        tokenCounter--;
    }

    // Allows owner to withdraw all ETH from contract
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");
        payable(owner()).transfer(balance);
        emit Withdrawn(owner(), balance);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface to check NFT ownership
interface IERC721 {
    function balanceOf(address owner) external view returns (uint256);
}

// A token gating contract for MyNFT holders
contract MyNFTGating {

    // Owner of the gating contract
    address public owner;

    // Address of the MyNFT contract
    address public nftContract;

    // Mapping of gated content
    mapping(string => bool) public isGated;

    // Mapping of content access
    mapping(address => mapping(string => bool)) public hasAccess;

    // Events
    event AccessGranted(address indexed user, string content);
    event AccessRevoked(address indexed user, string content);
    event ContentGated(string content);
    event ContentUngated(string content);

    // Sets the owner and NFT contract on deployment
    constructor(address _nftContract) {
        owner = msg.sender;
        nftContract = _nftContract;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Modifier to restrict access to NFT holders only
    modifier onlyNFTHolder() {
        require(
            IERC721(nftContract).balanceOf(msg.sender) > 0,
            "Must hold a MyNFT to access"
        );
        _;
    }

    // Gate a piece of content
    function gateContent(string memory content) public onlyOwner {
        isGated[content] = true;
        emit ContentGated(content);
    }

    // Ungate a piece of content
    function ungateContent(string memory content) public onlyOwner {
        isGated[content] = false;
        emit ContentUngated(content);
    }

    // Check if a wallet has access to gated content
    function checkAccess(address _address, string memory content)
        public
        view
        returns (bool)
    {
        if (!isGated[content]) return true;
        return IERC721(nftContract).balanceOf(_address) > 0;
    }

    // Grant special access to a wallet
    function grantAccess(address _address, string memory content)
        public
        onlyOwner
    {
        hasAccess[_address][content] = true;
        emit AccessGranted(_address, content);
    }

    // Revoke special access from a wallet
    function revokeAccess(address _address, string memory content)
        public
        onlyOwner
    {
        hasAccess[_address][content] = false;
        emit AccessRevoked(_address, content);
    }
}

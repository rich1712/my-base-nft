// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface to check NFT ownership
interface IERC721 {
    function balanceOf(address owner) external view returns (uint256);
}

// A governance contract for MyNFT holders to vote on proposals
contract MyNFTGovernance {

    // Owner of the governance contract
    address public owner;

    // Address of the MyNFT contract
    address public nftContract;

    // Proposal structure
    struct Proposal {
        uint256 id;
        string title;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        bool active;
        bool executed;
    }

    // Proposal counter
    uint256 public proposalCounter;

    // Mapping of proposals
    mapping(uint256 => Proposal) public proposals;

    // Mapping to track if a wallet has voted on a proposal
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // Events
    event ProposalCreated(uint256 indexed proposalId, string title);
    event VoteCast(address indexed voter, uint256 proposalId, bool support);
    event ProposalExecuted(uint256 indexed proposalId);
    event ProposalClosed(uint256 indexed proposalId);

    // Sets the owner and NFT contract on deployment
    constructor(address _nftContract) {
        owner = msg.sender;
        nftContract = _nftContract;
        proposalCounter = 0;
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
            "Must hold a MyNFT to vote"
        );
        _;
    }

    // Create a new proposal
    function createProposal(
        string memory title,
        string memory description
    ) public onlyOwner {
        proposalCounter++;
        proposals[proposalCounter] = Proposal({
            id: proposalCounter,
            title: title,
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            active: true,
            executed: false
        });
        emit ProposalCreated(proposalCounter, title);
    }

    // Vote on a proposal
    function vote(uint256 proposalId, bool support) public onlyNFTHolder {
        require(proposals[proposalId].active, "Proposal not active");
        require(!hasVoted[proposalId][msg.sender], "Already voted");
        hasVoted[proposalId][msg.sender] = true;
        if (support) {
            proposals[proposalId].votesFor++;
        } else {
            proposals[proposalId].votesAgainst++;
        }
        emit VoteCast(msg.sender, proposalId, support);
    }

    // Close a proposal
    function closeProposal(uint256 proposalId) public onlyOwner {
        require(proposals[proposalId].active, "Proposal not active");
        proposals[proposalId].active = false;
        emit ProposalClosed(proposalId);
    }

    // Mark a proposal as executed
    function executeProposal(uint256 proposalId) public onlyOwner {
        require(!proposals[proposalId].active, "Proposal still active");
        require(!proposals[proposalId].executed, "Already executed");
        proposals[proposalId].executed = true;
        emit ProposalExecuted(proposalId);
    }

    // Returns a proposal by ID
    function getProposal(uint256 proposalId)
        public
        view
        returns (Proposal memory)
    {
        return proposals[proposalId];
    }

    // Returns total number of proposals
    function totalProposals() public view returns (uint256) {
        return proposalCounter;
    }
}

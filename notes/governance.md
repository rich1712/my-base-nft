# Governance Notes

## What is Governance?
Governance allows NFT holders to vote on proposals
that affect the direction of the project. It gives
the community a voice in decision making.

## How to Use the Governance Contract
1. Deploy MyNFTGovernance.sol on Base Mainnet
2. Pass your MyNFT contract address to constructor
3. Call createProposal() to create a new proposal
4. NFT holders call vote() to cast their votes
5. Call closeProposal() to end voting
6. Call executeProposal() to mark as executed

## Functions
| Function | Description |
|----------|-------------|
| createProposal() | Create a new proposal |
| vote() | Cast a vote on a proposal |
| closeProposal() | Close voting on a proposal |
| executeProposal() | Mark proposal as executed |
| getProposal() | Returns proposal details |
| totalProposals() | Returns total proposals |
| hasVoted() | Check if wallet has voted |

## Voting Rules
- Only MyNFT holders can vote
- Each wallet can only vote once per proposal
- Votes cannot be changed after casting
- Only owner can create and close proposals

## Best Practices
- Keep proposal descriptions clear and concise
- Set a clear voting deadline before closing
- Announce proposals to the community first
- Execute proposals promptly after closing

## Future Plans
- Add voting deadline timestamps
- Add weighted voting based on NFT count
- Add automatic execution of passed proposals
- Add quorum requirements for valid votes

## License
MIT

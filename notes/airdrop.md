# Airdrop Notes

## What is an Airdrop?
An airdrop is when NFTs are sent for free to a list
of wallet addresses. It is commonly used to reward
early supporters or community members.

## How to Use the Airdrop Contract
1. Deploy MyNFTAirdrop.sol on Base Mainnet
2. Add recipient addresses using addRecipient()
3. Use giftNFT() on MyNFT.sol to send NFTs
4. Mark each recipient using markAirdropSent()
5. Use getRecipients() to view all recipients

## Functions
| Function | Description |
|----------|-------------|
| addRecipient() | Add one address to airdrop list |
| addRecipients() | Add multiple addresses at once |
| markAirdropSent() | Mark address as received |
| getRecipients() | Returns all recipients |
| totalRecipients() | Returns total recipient count |
| isRecipient() | Check if address is on list |

## Best Practices
- Double check all recipient addresses
- Test with one address first
- Keep a backup of the recipient list
- Verify all transactions on Basescan

## License
MIT

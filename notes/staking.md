# Staking Notes

## What is Staking?
Staking allows NFT holders to lock their NFTs in a
contract to earn rewards over time. The longer you
stake the more rewards you can earn.

## How to Use the Staking Contract
1. Deploy MyNFTStaking.sol on Base Mainnet
2. Call stake() with your NFT token ID
3. Check stakedDuration() to see how long staked
4. Call unstake() to retrieve your NFT
5. Use getStakedTokens() to view all staked NFTs

## Functions
| Function | Description |
|----------|-------------|
| stake() | Stake an NFT by token ID |
| unstake() | Unstake an NFT by token ID |
| getStakedTokens() | Returns all staked tokens |
| stakedDuration() | Returns staking duration in seconds |
| isStaked() | Check if a token is staked |
| stakedBy() | Check who staked a token |

## Best Practices
- Only stake NFTs you own
- Keep track of your staked token IDs
- Check stakedDuration regularly
- Test unstaking on testnet first

## Future Plans
- Add reward token for stakers
- Add minimum staking period
- Add bonus rewards for long term stakers
- Add leaderboard for top stakers

## License
MIT

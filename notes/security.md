# Security Notes

## Smart Contract Security Best Practices

### Access Control
- Only the owner can mint for free
- Only the owner can withdraw ETH
- Only the owner can pause/unpause minting
- Only the owner can update mint price
- Only the owner can manage whitelist

### Reentrancy Protection
- Withdraw function sends ETH only to owner
- SafeMint used for all minting operations
- Token counter updated after minting

### Input Validation
- Max supply checked before every mint
- Mint price checked before every mint
- Wallet limit checked before every mint
- Whitelist limit checked before every presale mint

### Recommendations Before Deploying
- Double check owner wallet address
- Test all functions on Base Sepolia testnet first
- Verify contract on Basescan after deployment
- Set correct mint price before going live
- Set correct max supply before going live
- Test withdraw function on testnet first

### Known Limitations
- Owner wallet is a single point of failure
- No timelock on owner functions
- No multisig support yet

## License
MIT

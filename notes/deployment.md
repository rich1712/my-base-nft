# Deployment Notes

## Contract Details
- Contract: MyNFT.sol
- Standard: ERC721 + ERC2981
- Network: Base Mainnet

## Contract Features
- Max supply: 100 NFTs
- Public mint price: 0.01 ETH
- Presale mint price: 0.005 ETH
- Max per wallet: 3 NFTs
- Max per whitelisted wallet: 5 NFTs
- Presale phase for whitelisted addresses
- Public sale phase for everyone
- Owner can mint and gift for free
- Owner can pause/unpause minting
- Owner can withdraw ETH
- Owner can set metadata URI
- Owner can update royalty info
- 5% default royalty on secondary sales
- Burn function for token owners

## Deployment Steps
1. Open Remix IDE (remix.ethereum.org)
2. Compile MyNFT.sol with Solidity ^0.8.20
3. Connect wallet to Base Mainnet
4. Deploy contract
5. Save contract address
6. Verify contract on Basescan

## After Deployment
- Call setBaseURI with your metadata URL
- Call setPresaleActive(true) to start presale
- Call setPublicSaleActive(true) to start public sale
- Test mint function
- Check contractBalance after mints
- Call withdraw to collect ETH

## License
MIT

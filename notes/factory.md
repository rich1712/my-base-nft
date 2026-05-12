# MyNFT Factory Contract

## What is the Factory Contract?
The factory contract is a registry that keeps track of all
deployed MyNFT contracts. It allows you to register and
look up all your deployed NFT collections in one place.

## Features
- Register deployed contract addresses
- Track all deployed contracts
- Check if an address is a registered contract
- View total number of deployed contracts

## How to Use
1. Deploy MyNFTFactory.sol on Base Mainnet
2. Deploy your MyNFT.sol contract
3. Call registerContract() with your MyNFT address
4. Use getDeployedContracts() to view all deployments

## Functions
| Function | Description |
|----------|-------------|
| registerContract() | Register a new deployed contract |
| getDeployedContracts() | Returns all deployed contracts |
| totalDeployed() | Returns total number of deployments |
| isDeployed() | Check if address is registered |

## License
MIT

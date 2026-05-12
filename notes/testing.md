# Testing Notes

## How to Test Contracts on Remix IDE

### Step 1 - Compile
1. Open Remix IDE at remix.ethereum.org
2. Create a new file and paste your contract
3. Click the Solidity Compiler tab on the left
4. Select compiler version 0.8.20
5. Click Compile and check for errors

### Step 2 - Deploy on JavaScript VM
1. Click the Deploy and Run tab on the left
2. Select JavaScript VM as the environment
3. Click Deploy to deploy locally
4. Use the deployed contract panel to test

### Step 3 - Test All Functions
Test these functions in order:

#### Minting
- [ ] Call setPublicSaleActive(true)
- [ ] Call mint() with 0.01 ETH
- [ ] Check tokenCounter increased
- [ ] Check mintedPerWallet updated

#### Whitelist
- [ ] Call addToWhitelist() with an address
- [ ] Call setPresaleActive(true)
- [ ] Call presaleMint() with 0.005 ETH
- [ ] Check whitelist mint worked

#### Owner Functions
- [ ] Call ownerMint() for free mint
- [ ] Call giftNFT() with multiple addresses
- [ ] Call setMintPrice() with new price
- [ ] Call setMaxPerWallet() with new limit
- [ ] Call pause() to pause minting
- [ ] Call unpause() to resume minting

#### Withdraw
- [ ] Call contractBalance() to check balance
- [ ] Call withdraw() to withdraw ETH
- [ ] Check balance is now zero

#### Burn
- [ ] Call burn() with a token ID
- [ ] Check tokenCounter decreased

### Step 4 - Deploy on Base Sepolia
1. Connect MetaMask to Base Sepolia testnet
2. Get free testnet ETH from Base Sepolia faucet
3. Deploy contract on Base Sepolia
4. Test all functions with real transactions
5. Verify everything works before mainnet

### Step 5 - Deploy on Base Mainnet
1. Connect MetaMask to Base Mainnet
2. Make sure you have real ETH on Base
3. Deploy contract on Base Mainnet
4. Verify contract on Basescan
5. Test mint function one more time

## License
MIT

# ipfs-url-encoder

Save storage and generate ipfs urls from hashes in solidity smart contracts.

Could not find any solidity base58btc encoder for ipfs urls, so I developed it by my self.
Hope you enjoy it.

The repo contains base58btc encoder that transforms ipfs hashes into ipfs urls
and two ERC721 metadata implementations.

Currently, this lib supports CID v0 only. 

## Running

```{shell}
npm install
npx hardhat compile
npx hardhat test
```

## Content

- `contracts/IpfsUrlEncoderV0.sol` - base58 encoder that transforms bytes32 hash into ipfs url v0,
- `contracts/v0/ERC721HashUrl.sol` - implementation of `tokenURI()`,
- `contracts/v0/ERC721IdUrl.sol` - implementation of `tokenURI()` that identifies tokenId with ipfs hash.

`IpfsUrlEncoderV0` is gas efficient. It is not multipurpose, it only takes bytes32 input.
CID v0 uses sha2-256, but it is obvious that the hash type is irrelevant here, only matters that it is 256 bits.

`ERC721HashUrl` and `ERC721IdUrl` implements only `tokenURI()`, not full ERC721Metadata.
It is enough to inherit from one of these contracts.
Exemplary ERC721 implementations are delivered at `contracts/test/v0/ERC721HashUrlTest.sol` and 
`contracts/test/v0/ERC721IdUrlTest.sol`.

## Storage saving

When ipfs url is stored in a contract, it takes at least 3 slots.
It is enough to store just ipfs hash, which takes 1 slot - and encode it with base58btc in `tokenUIR()` function on a call.
The contract `ERC721IdUrl` goes even further. It uses tokenId as an ipfs hash and it takes 0 slots.

Note that CID v0 uses sha2-256, it fits in 32 bytes. 
CID v1 can use hashes with greater length - this would not be so gas saving.

## Use cases

It is common to mint nfts in a batch and/or use common urls like this one 
```commandline
ipfs://QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU/21
```
In such cases there is little profit using this lib.

It is useful when each token has a specific url, for instance when they are minted independently.
Then the profit is 2 or 3 slots, it is 45k gas, on a single mint.

## Background

This is how CID v0 url are produced.

1. A user wants to publish some content.
2. Content is hashed with sha2-256.
3. The hash is prefixed with constants 0x12 and 0x20. 
   0x12 means that sha2-256 was used. 0x20 is the length of the output hash.
   This is so called multihash.
4. Multihash is encoded with base58btc. The result is CID, for instance QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU.

Note that having a hash, you can compute CID v0 uniquely, and conversely. 
So it is enough to store hashes instead of CIDs - CIDs take more bytes and cost more gas.

See [this](https://docs.ipfs.tech/concepts/content-addressing/#version-0-v0) 
and [this](https://proto.school/anatomy-of-a-cid/02) for reference.
To retrieve a hash from CID you can use [this](https://cid.ipfs.tech/).
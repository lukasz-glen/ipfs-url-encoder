import {expect} from 'chai'
import {ethers} from 'hardhat'

describe('IpfsUrlEncoderV0', () => {
  let ERC721HashUrlContract;
  let ERC721IdUrlContract;

  beforeEach(async () => {
    const [deployer] = await ethers.getSigners();

    const ERC721HashUrlFactory = await ethers.getContractFactory('ERC721HashUrlTest', deployer);
    ERC721HashUrlContract = await ERC721HashUrlFactory.deploy('ERC721HashUrl', 'HU');
    await ERC721HashUrlContract.deployed();

    const ERC721IdUrlFactory = await ethers.getContractFactory('ERC721IdUrlTest', deployer);
    ERC721IdUrlContract = await ERC721IdUrlFactory.deploy('ERC721IdUrl', 'IdU');
    await ERC721IdUrlContract.deployed();
  })

  it('ERC721HashUrlContract 0', async () => {
    const tokenId = 0;
    await ERC721HashUrlContract.mint(tokenId);
    await ERC721HashUrlContract.setTokenMetadataHash(tokenId, ethers.constants.HashZero);
    expect(await ERC721HashUrlContract.tokenURI(tokenId)).to.be.equal(''); // the contract checks zero metadata
  })

  it('ERC721HashUrlContract 1', async () => {
    const tokenId = 1;
    const tokenURI = '0x430D478B2A45C850A73F90AD02C0716674928FD03CE82639CD231D11205C6F2F';
    await ERC721HashUrlContract.mint(tokenId);
    await ERC721HashUrlContract.setTokenMetadataHash(tokenId, tokenURI);
    expect(
      await ERC721HashUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmSrPmbaUKA3YAjKoNbau5KiqmHPmSxYCvn66dA1vLmwbt'
    );
  })

  it('ERC721HashUrlContract 2', async () => {
    const tokenId = 2;
    const tokenURI = '0xBB18ACAE129A958173D2EE6058B91941CE62AFD3BDE6BD0FE7A9BF75EA3F9A6B';
    await ERC721HashUrlContract.mint(tokenId);
    await ERC721HashUrlContract.setTokenMetadataHash(tokenId, tokenURI);
    expect(
      await ERC721HashUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmavzmguTQr18Q3TaayxHGrAyYk7Sjejc3WMqciZysiuPQ'
    );
  })

  it('ERC721HashUrlContract 3', async () => {
    const tokenId = 3;
    const tokenURI = '0x9139839E65FABEA9EFD230898AD8B574509147E48D7C1E87A33D6DA70FD2EFBF';
    await ERC721HashUrlContract.mint(tokenId);
    await ERC721HashUrlContract.setTokenMetadataHash(tokenId, tokenURI);
    expect(
      await ERC721HashUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU'
    );
  })

  it('ERC721IdUrlContract 0', async () => {
    await ERC721IdUrlContract.mint(0);
    expect(await ERC721IdUrlContract.tokenURI(0)).to.be.equal('ipfs://QmNLei78zWmzUdbeRB3CiUfAizWUrbeeZh5K1rhAQKCh51');
  })

  it('ERC721IdUrlContract 1', async () => {
    const tokenId = ethers.BigNumber.from('0x430D478B2A45C850A73F90AD02C0716674928FD03CE82639CD231D11205C6F2F');
    await ERC721IdUrlContract.mint(tokenId);
    expect(
      await ERC721IdUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmSrPmbaUKA3YAjKoNbau5KiqmHPmSxYCvn66dA1vLmwbt'
    );
  })

  it('ERC721IdUrlContract 2', async () => {
    const tokenId = ethers.BigNumber.from('0xBB18ACAE129A958173D2EE6058B91941CE62AFD3BDE6BD0FE7A9BF75EA3F9A6B');
    await ERC721IdUrlContract.mint(tokenId);
    expect(
      await ERC721IdUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmavzmguTQr18Q3TaayxHGrAyYk7Sjejc3WMqciZysiuPQ'
    );
  })

  it('ERC721IdUrlContract 3', async () => {
    const tokenId = ethers.BigNumber.from('0x9139839E65FABEA9EFD230898AD8B574509147E48D7C1E87A33D6DA70FD2EFBF');
    await ERC721IdUrlContract.mint(tokenId);
    expect(
      await ERC721IdUrlContract.tokenURI(tokenId)
    ).to.be.equal(
      'ipfs://QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU'
    );
  })
})

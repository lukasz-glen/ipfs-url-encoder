// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../../v0/ERC721HashUrl.sol";

contract ERC721HashUrlTest is ERC721, ERC721HashUrl {

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function mint(uint256 tokenId) external {
        _mint(_msgSender(), tokenId);
    }

    function _exists(uint256 tokenId) internal view override(ERC721, ERC721HashUrl) returns (bool) {
        return ERC721._exists(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721HashUrl) returns (string memory) {
        return ERC721HashUrl.tokenURI(tokenId);
    }
}

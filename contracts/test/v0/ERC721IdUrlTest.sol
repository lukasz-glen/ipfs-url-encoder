// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../../v0/ERC721IdUrl.sol";

contract ERC721IdUrlTest is ERC721, ERC721IdUrl {

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function mint(uint256 tokenId) external {
        _mint(_msgSender(), tokenId);
    }

    function _exists(uint256 tokenId) internal view override(ERC721, ERC721IdUrl) returns (bool) {
        return ERC721._exists(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721IdUrl) returns (string memory) {
        return ERC721IdUrl.tokenURI(tokenId);
    }
}

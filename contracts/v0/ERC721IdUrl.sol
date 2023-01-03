// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./../IpfsUrlEncoderV0.sol";

/**
 * A partial implementation of ERC721Metadata. Name and Symbol are not provided.
 *
 * Token ids are uint256.
 * But they are interpreted are 32 byte ipfs hashes and they are used to compute token uri.
 * No additional storage is needed for token uri.
 */
abstract contract ERC721IdUrl is IERC721 {
    using IpfsUrlEncoderV0 for bytes32;

    function _exists(uint256 tokenId) internal view virtual returns (bool);

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        require(_exists(tokenId), "ERC721IdUrl: token does not exist");
        return bytes32(tokenId)._encodeURL_SHA2_256();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./../IpfsUrlEncoderV0.sol";

/**
 * A partial implementation of ERC721Metadata. Name and Symbol are not provided.
 *
 * For each token, there is stored an ipfs hash.
 */
abstract contract ERC721HashUrl is IERC721 {
    using IpfsUrlEncoderV0 for bytes32;

    mapping(uint256 => bytes32) private _metadataHash;

    event TokenURIChanged(uint256 indexed tokenId);

    function _exists(uint256 tokenId) internal view virtual returns (bool);

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        require(_exists(tokenId), "ERC721HashUrl: token does not exist");
        bytes32 metadataHash = _metadataHash[tokenId];
        if (metadataHash == 0) {
            return "";
        }
        return metadataHash._encodeURL_SHA2_256();
    }

    function _setTokenMetadataHash(uint256 tokenId, bytes32 metadataHash) internal virtual {
        require(_exists(tokenId), "ERC721HashUrl: URI set of nonexistent token");
        _metadataHash[tokenId] = metadataHash;
        emit TokenURIChanged(tokenId);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * The contract encodes ipfs hash into ipfs urls CID v0.
 * It includes base58btc encoder but not general, rather optimized for encoding bytes32 hashes.
 */
library IpfsUrlEncoderV0 {

    /**
     * Encodes ipfs hash into ipfs url. It is understood to be sha2-256 but this fact is irrelevant.
     * It is gas effective algorithm.
     * @param value ipfs hash, sha2-256
     * @return ipfs url of the form ipfs://QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU
     */
    function _encodeURL_SHA2_256(bytes32 value) internal pure returns (string memory) {
        uint256 value1 = uint256(value);
        unchecked {
            // technical value, it starts with ipfs:// ,
            // then there is the number 0x1220 * 0x10 ** 0x40 (represents multicodec, length and zero hash)
            // in base 58 - simply base 58, not base58btc
            bytes memory cid = hex"697066733a2f2f172c151325290607391d2c391b242225180a020b291b260929391d1b31222525202804120031280917120b280400";
            uint256 remainder = 0;
            uint256 i = 53;
            while (i > 7) {
                i --;
                uint256 a = uint256(uint8(cid[i])) + (value1 % 58) + remainder;
                remainder = a / 58;
                a %= 58;
                value1 /= 58;
                if (a < 9) { // 1 - 9
                    a += 49;
                } else if (a < 17) { // A - H
                    a += 56;
                } else if (a < 22) { // J - N
                    a += 57;
                } else if (a < 33) { // P - Z
                    a += 58;
                } else if (a < 44) { // a - k
                    a += 64;
                } else {             // m - z
                    a += 65;
                }
                cid[i] = bytes1(uint8(a));
            }
            return string(cid);
        }
    }
}

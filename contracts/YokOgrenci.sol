// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract eImza is EIP712 {

    constructor() EIP712("eImzaVerifier","1") {}

    mapping(bytes => bool) usedSignatures;
    mapping(bytes32 => bytes32) signatureToHashe;

    function internalVerify(bytes memory signature, bytes32 messageHash) internal pure {
        address recovered = ECDSA.recover(messageHash, signature);
    }



}
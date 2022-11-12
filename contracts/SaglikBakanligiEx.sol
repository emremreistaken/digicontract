// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract eImza is EIP712 {

    constructor() EIP712("eImzaVerifier","1") {}

    mapping(bytes => bool) usedSignatures;
    mapping(uint => bytes32) typeToContentHash;

    function verifyCek(bytes memory signature){
        bytes32 hashed = _hashTypedDataV4(
            
        );
    }



}
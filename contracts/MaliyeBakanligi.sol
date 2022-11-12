// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "./Kurum.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

contract MaliyeBakanligi is Kurum, EIP712 {

    constructor() EIP712("eImzaVerifier","1") {}

    mapping(uint => bytes32) typeToContentHash;

    function verifyCek(bytes memory signature){
        bytes32 hashed = _hashTypedDataV4(
            
        );
    }
}
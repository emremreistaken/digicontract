// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "./Kurum.sol";

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract MaliyeBakanligi is Kurum {

    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(bytes => bytes32) signatureToHash;

    function verify(bytes memory signature, bytes32 messageHash) external view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered]);
        return recovered;
    }

    function sign(bytes memory signature, bytes32 messageHash) external {
        require(authorized[tx.origin]);
        signatureToHash[signature] = messageHash;
    }
}
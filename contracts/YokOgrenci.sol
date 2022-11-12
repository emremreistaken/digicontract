// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract YokOgrenci is Kurum {

    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(bytes32 => bytes32) signatureToHash;

    function verify(bytes32 memory signature, bytes32 memory messageHash) external  returns(bool) {
        require(authorized[(ECDSA.recover(messageHash, signature))]);

    }

    function sign(bytes32 memory signature, bytes32 memory messageHash) external {
        signatureToHash[signature] = messageHash;
    }
}
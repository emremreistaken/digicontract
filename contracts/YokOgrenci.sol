// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract eImza is Kurum {

    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(bytes32 => bytes32) signatureToHash;

    function internalVerify(bytes32 memory signature, bytes32 memory messageHash) internal pure returns(address) {
        return ECDSA.recover(messageHash, signature);
    }

    function sign(bytes32 memory signature, bytes32 memory messageHash) external {
        signatureToHash[signature] = messageHash;
    }

    function verify(bytes32 memory signature, bytes32 memory messageHash) external {
        require(internalVerify(signature, messageHash) == );
    }

}
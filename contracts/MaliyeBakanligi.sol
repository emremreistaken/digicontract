// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./Kurum.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract MaliyeBakanligi is Kurum {
    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(uint => bytes) public cekNumberToSig;

    function verify(bytes memory signature, bytes32 messageHash) external view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered] != 0, "address not found");
    }

    function internalVerify(bytes memory signature, bytes32 messageHash) internal view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered] != 0, "address not found");
    }

    function cekExecution(bytes memory signature, bytes32 messageHash) public returns(bool) {
        require(authorized[msg.sender] == 2, "caller is not a pharmacy"); // 2 for pharmacy
        address recovered = internalVerify(signature, messageHash);
        usedSignatures[signature] = true;
        return usedSignatures[signature];
    }

    function publishCek(uint cekNo, bytes memory signature) external {
        require(authorized[msg.sender] == 1, "caller is not valid");
        cekNumberToSig[cekNo] = signature;
    }
}
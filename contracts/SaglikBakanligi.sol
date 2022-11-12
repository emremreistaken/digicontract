// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "./Kurum.sol";

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract SaglikBakanligi is Kurum {
    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(uint => bytes) receteNumberToSignature;

    function verify(bytes memory signature, bytes32 messageHash) public view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered] != 0, "address not found");
    }

    function receteExecution(bytes memory signature, bytes32 messageHash) public returns(bool) {
        require(authorized[msg.sender] == 2, "caller is not a pharmacy"); // 2 for pharmacy
        address recovered = verify(signature, messageHash);
        require(authorized[recovered] == 1, "signer is not a doctor"); // 1 for doctor
        usedSignatures[signature] = true;
        return usedSignatures[signature];
    }

    function publishRecete(uint receteNo, bytes memory signature) external {
        require(authorized[msg.sender] == 1, "caller is not a pharmacy");
        receteNumberToSignature[receteNo] = signature;
    }
}
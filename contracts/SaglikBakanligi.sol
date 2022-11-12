// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "./Kurum.sol";

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract SaglikBakanligi is Kurum {
    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    function verify(bytes memory signature, bytes32 messageHash) public view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
    }

    function receteKullan(bytes memory signature, bytes32 messageHash) {
        require(authorized[msg.sender] == 2, "caller is not a pharmacy");
        address recovered = verify(signature, messageHash);
        require(authorized[recovered] == 1, "signer is not a doctor");
        usedSignatures[signature] == true;
        return usedSignatures[signature];
    }

    function publishRecete(uint receteNo, bytes memory signature) external 
}
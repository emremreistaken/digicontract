// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "./Kurum.sol";

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Yok is Kurum {

    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    mapping(uint => mapping(bytes32 => bytes)) idToHashToSign;

    function verify(bytes memory signature, bytes32 messageHash) external view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered] != 0, "address not found");
    }

    function sign(uint id, bytes memory signature, bytes32 messageHash) external {
        require(authorized[msg.sender] == 1);
        idToHash[id] = messageHash;
    }
}
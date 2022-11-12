// SPDX License Identifier: MIT
pragma solidity >=0.8.0;
import "./Kurum.sol";

contract SaglikBakanligi is Kurum {
    constructor(string memory _name, address _signer) Kurum(_name, _signer) {}

    function verify(bytes memory signature, bytes32) public {

    }
}
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./Kurum.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

contract NoterHizmetleri is Kurum, EIP712 {
    constructor(string memory _name, string memory version, address _signer) Kurum(_name, _signer) EIP712(_name, version) {}

    mapping(uint => bytes) public cekNumberToSignature;

    function internalVerify(bytes memory signature, bytes32 messageHash) internal view returns (address recovered) {
        recovered = ECDSA.recover(messageHash, signature);
        require(authorized[recovered] != 0, "address not found");
    }

    function cekExecution(bytes memory signature, bytes32 messageHash) public returns(bool) {
        require(!usedSignatures[signature]);
        address recovered = internalVerify(signature, messageHash);
        usedSignatures[signature] = true;
        return usedSignatures[signature];
    }

    function publishCek(uint receteNo, bytes memory signature) external {
        receteNumberToSignature[receteNo] = signature;
        userToId[msg.sender].push(receteNo);
    }

    function verify(bytes memory signature, string memory name, string memory value) external view returns (address recovered) {


        bytes32 hashed = _hashTypedDataV4(keccak256(
            abi.encode(
                keccak256(
                    "check(string name,string value)"
                ),
                keccak256(bytes(name)),
                keccak256(bytes(value))
            )
        ));

        return ECDSA.recover(hashed, signature);
    }

    function getChainID() view public returns(uint256 _b) {
        return block.chainid;
    }
    
}
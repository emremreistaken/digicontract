// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Kurum is Ownable {
    mapping(address => bool) authorized;
    mapping(bytes => bool) usedSignatures;

    string kurumName;
    address kurumSigner;

    constructor(string memory _name, address _kurumsigner){
        kurumName = _name;
        kurumSigner = _kurumsigner;
    }

    modifier onlyAuthorized() virtual {
        require (authorized[msg.sender], "not authorized");
        _;
    }

    function getAuthorized(bytes memory signature, bytes32 messageHash) external {
        require(!usedSignatures[signature], "signature is used");

        address recovered = ECDSA.recover(messageHash, signature);

        require(recovered == kurumSigner, "silivri");

        authorized[msg.sender] = true;
    }

    function deAuthorize(address _address) external onlyOwner {
        authorized[_address] = false;
    }

    function isAuthorized(address _address) external virtual view returns(bool){
        return authorized[_address];
    }
}
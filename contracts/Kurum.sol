// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Kurum is Ownable {
    mapping(address => uint) public authorized;
    mapping(bytes => bool) public usedSignatures;
    mapping(address => uint[]) public userToId;

    string public kurumName;
    address public kurumSigner;

    constructor(string memory _name, address _kurumsigner){
        kurumName = _name;
        kurumSigner = _kurumsigner;
    }

    modifier onlyAuthorized(uint[] memory _authTypes) virtual {
        uint c;
        for(uint i = 0; i < _authTypes.length; i++){
            if(authorized[msg.sender] == _authTypes[i] && c != 1){
                c = 1;
            }
        }
        require(c == 1, "not authorized");
        _;
    }

    modifier onlyKurumSigner() virtual {
        require(msg.sender == kurumSigner, "not authorized");
        _;
    }

    function setAuthorized(address _toBeAuthed, uint _authType) external onlyKurumSigner {
        authorized[_toBeAuthed] = _authType;
    }

    function deAuthorize(address _address) external onlyOwner {
        authorized[_address] = 0;
    }

    function authLevel(address _address) external virtual view returns(uint){
        return authorized[_address];
    }
}
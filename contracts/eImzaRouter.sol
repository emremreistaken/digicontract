// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "./IKurum.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract eImzaRouter is Ownable {
    mapping(uint => address) public indexToKurumAdresi;
    uint public kurumCount;

    function verify(bytes memory signature, bytes32 messageHash, uint kurumIndex) public {
        address kurumAdresi = indexToKurumAdresi[kurumIndex];
        IKurum kurum = IKurum(kurumAdresi);
        require(kurum.isAuthorized(msg.sender), "kurumda sorgulama yetkiniz yok");

        (bool success, ) = kurumAdresi.call(abi.encodeWithSignature("verify(bytes,bytes32,uint256)", signature, messageHash));
        require(success, "failed");
    }

    function addKurum(address _kurum) external onlyOwner {
        indexToKurumAdresi[kurumCount] = _kurum;
        kurumCount++;
    }
}
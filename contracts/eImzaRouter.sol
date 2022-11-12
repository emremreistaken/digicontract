// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "./KurumInterface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract eImzaRouter is Ownable {
    mapping(uint => address) public indexToKurumAdresi;
    uint public kurumCount;

    function verify(bytes memory signature, bytes32 hashed, uint kurumIndex) public {
        address kurumAdresi = indexToKurumAdresi[kurumIndex];
        IKurum kurum = IKurum(kurumAdresi);
        require(kurum.isAuthorized(msg.sender), "kurumda sorgulama yetkiniz yok");

        (bool success, ) = kurumAdresi.call(abi.encodeWithSignature("verify(bytes32,bytes32,uint256)", signature, hashed));
        require(success, "failed");
    }

    function addKurum(address _kurum) external onlyOwner {
        indexToKurumAdresi[kurumCount] = _kurum;
        kurumCount++;
    }
}
// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

import "./IKurum.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract eImzaRouter is Ownable {
    mapping(uint => address) public indexToKurumAdresi;
    uint public kurumCount;

    function verify(bytes memory signature, bytes32 messageHash, uint kurumIndex) public returns(address adr) {
        address kurumAdresi = indexToKurumAdresi[kurumIndex];
        IKurum kurum = IKurum(kurumAdresi);
        require(kurum.isAuthorized(msg.sender), "kurumda sorgulama yetkiniz yok");

        (bool success,bytes memory result) = kurumAdresi.call(abi.encodeWithSignature("verify(bytes,bytes32)", signature, messageHash));
        require(success, "failed");
        adr = abi.decode(result, (adress));
        return;
    }

    function addKurum(address _kurum) external onlyOwner {
        indexToKurumAdresi[kurumCount] = _kurum;
        kurumCount++;
    }
}
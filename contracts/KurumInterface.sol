// SPDX License Identifier: MIT
pragma solidity >=0.8.0;

interface IKurum {
    function isAuthorized(address _address) external view returns(bool);
}
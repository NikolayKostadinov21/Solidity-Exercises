// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

interface Upgradeable {
    function upgradeTo(address newImplementation) external;
}

contract UpgradableProxy {

    address private _implementation;

    constructor(address implementation) {
        _implementation = implementation;
    }


    function upgradeTo(address newImplementation) public {
        _implementation = newImplementation;
    }

    function() external payable {
        (bool success, bytes memory returnData) = address(_implementation).call(msg.data);
        require(success, "Upgrading call failed");
    }

}
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

contract MyContract {
    address private _target;

    constructor(address target) {
        _target = target;
    }

    function forward(bytes memory data) public {
        (bool success, bytes memory returnData) = address(_target).call(data);
        require(success, "Forwarding call failed");
    }
}
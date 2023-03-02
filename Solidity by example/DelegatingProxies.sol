// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

contract DelegatingProxy {

    address private _target;

    constructor(address target) {
        _target = target;
    }

    function delegate(address newTarget) public {
        _target = newTarget;
    }

    function() external payable {
        address _target = _target;
        (bool success, bytes memory returnData) = address(_target).call(msg.data);
        require(success, "Delegating call failed");
    }

}
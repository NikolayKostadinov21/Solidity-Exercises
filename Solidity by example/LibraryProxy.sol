// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

contract LibraryProxy {

    address private _library;

    constructor(address Library) {
        _library = Library;
    }

    function forward(bytes memory data) public {
        (bool success, bytes memory returnData) = address(_library).delegateCall(msg.data);
        require(success, "Library call failed");
    }

}
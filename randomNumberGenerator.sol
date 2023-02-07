// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.7;

contract RandomNumberGenerator {

    uint number = 0;

    //Here it would be created our hash function
    //Firstly let's define everything
    //msg.sender - the sender of the message
    //block timestamp it's a number with ~20 digits
    //our number
    //abi.encodePacked
    //If we want to get a random number between 1 and 99 -> number % 100
    function setNumber() external {
        number = uint(keccak256(abi.encodePacked(msg.sender, block.timestamp, number)));
    }

    function getNumber() external view returns (uint) {
        return number;
    }

}
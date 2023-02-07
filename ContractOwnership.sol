// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.7;

contract ContractOwnership {

    address owner;
    address proposedOwner;
    uint256 timeLimit;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OwnershipAccepted(address indexed newOwner);
    event TimeLimitEvent(uint256 timelimit);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender != owner);
        _;
    }

    modifier onlyProposedOwner() {
        require(msg.sender != proposedOwner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0x0));
        emit OwnershipTransferred(owner, newOwner);
        proposedOwner = newOwner;
        timeLimit = block.timestamp;
    }

    function transferAccepted() payable public onlyProposedOwner {
        emit TimeLimitEvent(timeLimit);
        require(block.timestamp < 1 seconds + timeLimit, "somethingasdasdasdadsdasdasdasdadasdasd");
        emit OwnershipAccepted(msg.sender);
        owner = msg.sender;
    }

}
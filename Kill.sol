// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

// selfdestruct
// -delete contract
// -force send Ether to any address

contract Kill {
    //we are declaring the constructor as payable so we can send ether to this contract, when we deploy this contract 
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {

    //this will return the amount of ether that is stored in the Helper contract
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    //this function will call kill on the Kill contract
    function kill(Kill _kill) external {
        _kill.kill();
    }

}

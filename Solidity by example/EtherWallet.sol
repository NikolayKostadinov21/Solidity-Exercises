// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

//anyone can send ETH
//Only the owner an withdraw

contract EtherWallet {

    address payable public owner;

    mapping(address => uint256) balances;

    constructor () {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function withdraw(uint256 amountToWithdraw) public onlyOwner {
        payable(msg.sender).transfer(amountToWithdraw);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.17;

contract MultipleCoinsContract {

    mapping(address => mapping(uint256 => uint)) public balances;

    //You can use enumerator but I am not using it due to not understandable error
    enum Coins {
        Blue,
        Red,
        Green
    }

    constructor() {
        balances[msg.sender][0] = 10000; //red
        balances[msg.sender][1] = 10000; //green
        balances[msg.sender][2] = 10000; //blue
    }

    function sendCoins(address _to, uint256 _amount, uint256 _coinIndex) public payable {
        require(balances[msg.sender][_coinIndex] >= _amount);

        balances[msg.sender][_coinIndex] -= _amount;

        balances[_to][_coinIndex] += _amount;

    }

}
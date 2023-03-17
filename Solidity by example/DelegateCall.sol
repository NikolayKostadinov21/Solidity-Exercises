// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

/*
    A calls B, sends 100 wei
            B calls C, sends 50 wei
    A ---> B ---> C
                  msg.sender = B
                  msg.value = 50
                  execute coe on C'state variables
                  use ETH in C

    A calls B, sends 100 wei
            B delegatecall C
    A ---> B ---> C
                  msg.sender = A
                  msg.value = 100
                  execute code on B's state variables
                  use ETH in B

*/

contract TestDelegateCall {
    uint256 public number;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _number) external payable {
        number = _number;
        sender = msg.sender;
        value = msg.value;
    }
}


    
contract DelegateCall {
    uint256 public number;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _number) external payable {
    }
}

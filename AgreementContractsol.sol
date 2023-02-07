// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.17;

contract AgreementContract {

    address[] public owners;
    uint public nextToVote = 0;

    struct Proposer {
        uint value;
        address addr;
        uint timestamp;
    }

    Proposer public proposer;

    modifier canPropose {
        for (uint index = 0; index < owners.length; index++) {
            if (owners[index] == msg.sender) {
                _;
                break;
            }
        }
        _;
    }

    constructor (address[] memory _owners) {
        owners = _owners;
    }

    //fallback function initializer
    fallback() external payable {}

    function propose (uint value, address addr) public canPropose {
        require(block.timestamp > proposer.timestamp + 5 minutes);

        proposer = Proposer(value, addr, block.timestamp);
        nextToVote = 0;
    }

    function vote() public {
        require(nextToVote < owners.length);
        require(owners[nextToVote] == msg.sender);
        require(block.timestamp <= proposer.timestamp + 5 minutes);
        require(address(this).balance >= proposer.value);

        nextToVote++;

        if (nextToVote >= owners.length) {
            payable(proposer.addr).transfer(proposer.value);
        }
    }

}
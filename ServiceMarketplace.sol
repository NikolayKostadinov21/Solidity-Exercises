// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.7;

contract ServiceMarketplace {

    address owner;

    uint256 lastWitdraw = 0;
    uint256 lastBuy = 0;

    event LogBuying(address indexed buyer, uint timestamp);

    modifier onlyAfterTwoMinutes() {
        require(block.timestamp > lastBuy + 2 minutes, "try after two minutes");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyOncePerHour() {
        require(block.timestamp > lastWitdraw +  1 hours);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function buyService() payable public onlyAfterTwoMinutes {
        require(msg.value >= 1 ether);

        lastBuy = block.timestamp;
        emit LogBuying(msg.sender, block.timestamp);

        uint amountToReturn = msg.value - 1 ether;

        if (amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
    }

    function witdraw(uint value) public onlyOwner onlyOncePerHour {
        require(value <= 5 ether);
        require(address(this).balance >= value);
        lastWitdraw = block.timestamp;

        payable(owner).transfer(value);
    }
}

// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity 0.8.7;

contract Auction {

    address owner;
    address public highestBidder;

    uint public startBlock;
    uint public endBlock;

    bool public canceled;

    mapping(address => uint256) public fundsByBidder;

    event LogBid(address bidder, uint bid, address highestBidder, uint256 highestBid);
    event LogWithdraw(address withdrawer, address withdrawalAccount, uint withdrawalAmount);
    event LogCanceled();


    constructor(uint _startBlock, uint _endBlock) {
        require(_startBlock <= _endBlock);
        require(_startBlock > block.number);

        owner = msg.sender;
        startBlock = _startBlock;
        endBlock = _endBlock;
    }

    modifier onlyRunning() {
        require(canceled == false);
        require((block.number > startBlock) && (block.number < endBlock));
        _;
    }

    modifier onlyNotCanceled() {
        require(canceled == false);
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyNotOwner() {
        require(msg.sender != owner);
        _;
    }

    modifier onlyAfterStart() {
        require(block.number > startBlock);
        _;
    }

    modifier onlyBeforeEnd() {
        require(block.number < endBlock);
        _;
    }

    modifier onlyEndedOrCanceled() {
        require(canceled == true || block.number > endBlock);
        _;
    }

    function placeBid() payable public onlyNotCanceled onlyNotOwner onlyAfterStart onlyBeforeEnd {
        //reject payments of 0 ETH
        require(msg.value > 0);

        //JUST A REGULAR NEW BID
        uint newBid = fundsByBidder[msg.sender] + msg.value;

        //get the current highest bid
        uint lastHighestBid = fundsByBidder[highestBidder];

        require(newBid > lastHighestBid);

        fundsByBidder[msg.sender] = newBid;
        highestBidder = msg.sender;

        emit LogBid(msg.sender, newBid, highestBidder, lastHighestBid);
    }

    function withdraw() public onlyEndedOrCanceled {
        address withdrawalAccount;
        uint withdrawalAmount;

        if (canceled == true) {
            withdrawalAmount = fundsByBidder[msg.sender];
        } else {
            //highest bidder won the auction so he cannot witdraw his money
            require(msg.sender != highestBidder);

            if (msg.sender == owner) {
                withdrawalAmount = fundsByBidder[highestBidder];
            } else {
                withdrawalAmount = fundsByBidder[msg.sender];
            }
        }

        require(withdrawalAmount > 0);

        fundsByBidder[withdrawalAccount] -= withdrawalAmount;

        payable (msg.sender).transfer(withdrawalAmount);

        emit LogWithdraw(msg.sender, withdrawalAccount, withdrawalAmount);
    }

    function cancelAuction() public onlyOwner onlyBeforeEnd onlyNotCanceled {
        canceled = true;
        emit LogCanceled();
    }

}
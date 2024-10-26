// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import{PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversion() >= MINIMUM_USD, "insuffcient ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public  {
        //for{/* starting index, ending index, step amount */}
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);
        //actuall withdraw the funds

        // //using transfer method
        // //msg.sender = address
        // //payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);

        // //using send method
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        //using call method
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
    // require(msg.sender == i_owner, "must be owner");
    if (msg.sender != i_owner) revert NotOwner();
    _;
    }

}
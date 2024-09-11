// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import{PriceConverter} from "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;

    uint256 public minimumUSD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)public addressToAmountFunded;


    function fund() public payable {
        require(msg.value.getConversion() >= minimumUSD, "insuffcient ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

}
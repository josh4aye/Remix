// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUSD = 5 * 1e18; // Set to 5 USD in terms of wei (since price data will be in wei)

    function fund() public payable {
        uint256 ethAmountInUSD = getConversionRate(msg.value);
        require(ethAmountInUSD >= minimumUSD, "Insufficient ETH sent for minimum USD amount");
    }

    function getPrice() public view returns (uint256) {
        // Chainlink price feed for ETH/USD on Goerli: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            /*uint80 roundID*/,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        // Convert to 18 decimal places (Chainlink ETH/USD has 8 decimal places)
        return uint256(answer * 1e10); // Convert price to 18 decimals
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        // Convert ethAmount (in wei) to USD based on ETH price
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}

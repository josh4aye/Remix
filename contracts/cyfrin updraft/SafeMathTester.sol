// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{

    uint8 public bigNimber = 255;

    function add() public{
        unchecked{bigNimber ++;}
    }
}
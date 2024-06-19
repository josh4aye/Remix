// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Fallback
{
    event log(string func, uint256 gas);

    fallback() external payable
    {
        emit log("fallback", gasleft());
    }
    
    receive() external payable
    {
        emit log("receive", gasleft());
    }

    function getBalance() public view returns (uint)
    {
        return address(this).balance;
    }
}

contract SendToFallback
{
    function transferToFallback(address payable _to) public payable
    {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable
    {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Falied to send ether");
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Callee
{
    uint public x;
    uint public value;

    function setX(uint _xr) public returns (uint)
    {
        x = _xr;
        return x;
    }

    function setXandSendEther(uint _xx) public payable returns (uint, uint) 
    {
        x = _xx;
        value = msg.value;

        return (x, value);
    }
}

contract Caller
{
    function setX(Callee _callee, uint _xq) public
    {
        uint x = _callee.setX(_xq);
    }

    function setXFromAddress(address _addr, uint _xp) public
    {
        Callee callee = Callee(_addr);
        callee.setX(_xp);
    }

    function setXandSendEther(Callee _callee, uint _xi) public payable
    {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_xi);
    }
}
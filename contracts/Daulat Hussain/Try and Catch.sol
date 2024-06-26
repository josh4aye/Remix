// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Foo
{
    address public owner;  

    constructor(address _owner)
    {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint x) public pure returns (string memory)
    {
        require (x != 0, "require fail");
        return "my function was called";
    }
}

contract Bar
{
    event log(string message);
    event logbytes(bytes data);

    Foo public foo;

    constructor ()
    {
        foo = new Foo(msg.sender);
    }

    function trycatchExternalCall(uint _i) public
    {
        try foo.myFunc(_i) returns(string memory result)
        {
            emit log("result");
        }
        catch
        {
            emit log("external call failed");
        }
    }

    function trycatchNewContract(address _owner) public
    {
        try new Foo(_owner) returns (Foo foo)
        {
            emit log("Foo created");
        }
        catch Error(string memory reason)
        {
            emit log(reason);
        }
        catch (bytes memory reason)
        {
            emit logbytes(reason);
        }
    }

}
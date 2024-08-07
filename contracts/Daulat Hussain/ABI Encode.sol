// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC20 {
    function transfer(address, uint) external;  
}

contract Token{
    function transfer(address, uint) external{

    }
}

contract AbiEncode{
    function test(address _contract, bytes calldata data) external {
        (bool ok, ) = _contract.call(data);
        require(ok, "call falied");
    }

    function encodeWithSignature(address to, uint amount)
        external
        pure
        returns (bytes memory){
            // Typo is not checked - "transfer(address, uint)"
            return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }
    
    function encodedWithSelector(address to, uint amount)
        external
        pure
        returns (bytes memory){
            // type is not checked - (IERC20.transfer.selector, true, amount)
            return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
        }
    function encodeCall(address to, uint amount) external pure returns (bytes memory){
        // Typo and type erroes will not compile
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}
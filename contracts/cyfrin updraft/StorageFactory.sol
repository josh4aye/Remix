// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{

    SimpleStorage[] public listofsimpleStorageContracts;

    SimpleStorage newSimpleStorageContract;

    function createSimpleStorageContract() public {
        newSimpleStorageContract = new SimpleStorage();
        listofsimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        listofsimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return listofsimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
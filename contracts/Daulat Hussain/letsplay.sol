// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol";

contract Realestate
{

    using Math for uint256;

    struct Estate
    {
        address owner;
        string location;
        string description;
        string title;
        uint256 number;
        uint256 price;
        bool forsale;
    }

    mapping (uint256 => Estate) public Properties;

    uint256[] public estateID;

    event estatesold (uint256 estateID);

    function listpropertyforsale
    (
        uint256 _number,
        uint256 _price,
        uint256 _estateID,
        string memory _title,
        string memory _location,
        string memory _description
    ) public
    {
        Estate memory newEstate = Estate
        ({
            owner: msg.sender,
            location: _location,
            description: _description,
            title: _title,
            number: _number,
            forsale: true,
            price: _price
        });

        Properties[_estateID] = newEstate;
        estateID.push(_estateID);
    }

    function buyproperty(uint256 _estateID) public payable
    {
        Estate storage estate = Properties[_estateID];

        require(estate.forsale, "Property is not for sale");
        require(estate.price <= msg.value, "Insufficient funds");
    }

}
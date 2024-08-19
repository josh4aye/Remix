// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol";

contract RealEstate
{

    using Math for uint256;

    struct Property
    {
        string location;
        string description;
        uint256 price;
        bool forsale;
        address owner;
        string title;
    }

    mapping (uint256 => Property) public propertylist;

    uint256 [] public propertyID;

    event propertysold (uint256 propertyID);

    function listpropertyforsale
    (
        string memory _location,
        string memory _description,
        uint256 _price,
        string memory _title,
        uint256 _propertyID
    )public
    {
        Property memory newproperty = Property
        ({
            location: _location,
            description: _description,
            price: _price,
            forsale: true,
            owner: msg.sender,
            title: _title
        });
        
        propertylist[_propertyID] = newproperty;
        propertyID.push(_propertyID);
    }


    function buyproperty(uint256 _propertyID) public payable
    {
        Property storage property = propertylist[_propertyID];

        require(property.forsale, "Property is not for sale");
        require(property.price <= msg.value, "Insufficient funds");

        property.owner = msg.sender;
        property.forsale = false;

        payable (property.owner).transfer(property.price);

        emit propertysold(_propertyID);

    }

}

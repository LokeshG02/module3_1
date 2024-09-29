// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MiniStore {
    struct Item {
        string name;
        uint256 price; 
        uint256 stock; 
    }

    mapping(uint256 => Item) public items;
    uint256 public itemCount;
    uint256 public totalSales;

    constructor() {
        addItem("Mango", 5 , 500); 
        addItem("Apple", 2 , 50);
        addItem("Guava", 3 , 100);
        addItem("Kiwi", 10 , 300); 
    }

    function addItem(string memory _name, uint256 _price, uint256 _stock) internal {
        itemCount++;
        items[itemCount] = Item(_name, _price, _stock);
        assert(keccak256(abi.encodePacked(items[itemCount].name)) == keccak256(abi.encodePacked(_name)));
    }

    function buyItem(uint256 _itemId, uint256 _quantity ) public payable {
        require(_itemId > 0 && _itemId <= itemCount, "Item does not exist.");
        require(items[_itemId].stock >= _quantity, "Not enough stock.");
        uint256 totalCost = items[_itemId].price * _quantity;
        items[_itemId].stock -= _quantity;
        totalSales += totalCost;
        assert(totalSales >= totalCost);
    }

    function refundRequest() public pure {
        revert("Refunds are not allowed.");
    }
}

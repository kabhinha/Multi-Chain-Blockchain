// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RetailChain {
    struct Product {
        uint256 productId;
        uint256 processedBatchId;
        string productName;
        uint256 quantity;
        string expiryDate;
        string qrCodeHash; // Hash linking to product details
    }

    mapping(uint256 => Product) public products;
    uint256 public productCounter;

    event ProductLogged(uint256 productId, uint256 processedBatchId);

    function logProduct(
        uint256 _processedBatchId,
        string memory _productName,
        uint256 _quantity,
        string memory _expiryDate,
        string memory _qrCodeHash
    ) public returns (uint256) {
        productCounter++;
        products[productCounter] = Product(
            productCounter,
            _processedBatchId,
            _productName,
            _quantity,
            _expiryDate,
            _qrCodeHash
        );
        emit ProductLogged(productCounter, _processedBatchId);
        return productCounter;
    }

    function getProduct(uint256 _productId)
        public
        view
        returns (Product memory)
    {
        return products[_productId];
    }
}

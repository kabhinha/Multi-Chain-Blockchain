// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConsumerChain {
    struct ProductVerification {
        uint256 productId;
        string productName;
        string originDetails;
        string qualityStatus;
        string expiryDate;
    }

    mapping(uint256 => ProductVerification) public verifications;

    function verifyProduct(
        uint256 _productId,
        string memory _productName,
        string memory _originDetails,
        string memory _qualityStatus,
        string memory _expiryDate
    ) public {
        verifications[_productId] = ProductVerification(
            _productId,
            _productName,
            _originDetails,
            _qualityStatus,
            _expiryDate
        );
    }

    function getProductDetails(uint256 _productId)
        public
        view
        returns (ProductVerification memory)
    {
        return verifications[_productId];
    }
}

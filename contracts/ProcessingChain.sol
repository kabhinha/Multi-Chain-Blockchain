// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProcessingChain {
    struct ProcessedBatch {
        uint256 batchId;
        uint256 sourceBatchId;
        string productName;
        uint256 quantity;
        string qualityCheck; // Passed/Failed
        bool isComplete;
    }

    mapping(uint256 => ProcessedBatch) public processedBatches;
    uint256 public processCounter;

    event ProcessingStarted(uint256 batchId, uint256 sourceBatchId);
    event QualityCheckUpdated(uint256 batchId, string status);

    function startProcessing(
        uint256 _sourceBatchId,
        string memory _productName,
        uint256 _quantity
    ) public returns (uint256) {
        processCounter++;
        processedBatches[processCounter] = ProcessedBatch(
            processCounter,
            _sourceBatchId,
            _productName,
            _quantity,
            "",
            false
        );
        emit ProcessingStarted(processCounter, _sourceBatchId);
        return processCounter;
    }

    function updateQualityCheck(uint256 _batchId, string memory _status) public {
        processedBatches[_batchId].qualityCheck = _status;
        processedBatches[_batchId].isComplete = keccak256(abi.encodePacked(_status)) == keccak256(abi.encodePacked("Passed"));
        emit QualityCheckUpdated(_batchId, _status);
    }

    function getProcessedBatch(uint256 _batchId)
        public
        view
        returns (ProcessedBatch memory)
    {
        return processedBatches[_batchId];
    }
}

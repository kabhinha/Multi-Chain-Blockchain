// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AgriChain {
    struct Batch {
        uint256 batchId;
        string cropType;
        uint256 quantity;
        string farmLocation;
        string certification; // Organic, non-GMO, etc.
        address farmer;
        bool certified;
    }

    mapping(uint256 => Batch) public batches;
    uint256 public batchCounter;

    event BatchRegistered(uint256 batchId, string cropType, address farmer);
    event CertificationUpdated(uint256 batchId, string certification);

    function registerBatch(
        string memory _cropType,
        uint256 _quantity,
        string memory _farmLocation
    ) public returns (uint256) {
        batchCounter++;
        batches[batchCounter] = Batch(
            batchCounter,
            _cropType,
            _quantity,
            _farmLocation,
            "",
            msg.sender,
            false
        );
        emit BatchRegistered(batchCounter, _cropType, msg.sender);
        return batchCounter;
    }

    function updateCertification(uint256 _batchId, string memory _certification)
        public
    {
        require(
            batches[_batchId].farmer == msg.sender,
            "Only the farmer can update certification"
        );
        batches[_batchId].certification = _certification;
        batches[_batchId].certified = true;
        emit CertificationUpdated(_batchId, _certification);
    }

    function getBatch(uint256 _batchId)
        public
        view
        returns (Batch memory)
    {
        return batches[_batchId];
    }
}

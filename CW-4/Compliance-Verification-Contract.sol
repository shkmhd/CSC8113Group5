// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for LogContract - assuming it remains the same
interface ILogContract {
    function getLogEntry(uint index) external view returns (uint actorID, uint8 operation, uint userID, uint serviceName);
}

// Interface for Agreement - assuming it remains the same
interface IAgreement {
    function checkConsent(bytes32 dataPurposeHash, uint userId) external view returns (bool);
}

// Updated IDataUsage interface to include verifyDataPurpose method
interface IDataUsage {
    //function getDataPurpose(uint id) external view returns (uint actorID, uint serviceName, uint servicePurpose, uint operation, uint userID);
    function verifyDataPurpose(uint _actorID, uint _userID, uint8 _operation) external view returns (bool);
}

// Verification contract using the corrected interface and logic
contract Verification {
    ILogContract private logContract;
    IAgreement private agreementContract;
    IDataUsage private dataUsageContract;

    event LogVerificationDetails(uint logIndex, bytes32 dataPurposeHash, bool isCompliant, uint actorID, uint8 operation, uint userID, bool consent);

    constructor(address _dataUsageContractAddress, address _agreementContractAddress, address _logContractAddress) {
        logContract = ILogContract(_logContractAddress);
        agreementContract = IAgreement(_agreementContractAddress);
        dataUsageContract = IDataUsage(_dataUsageContractAddress);
    }

    function verifyLogEntry(uint logIndex, bytes32 dataPurposeHash) public returns (bool isCompliant) {
        (uint actorID, uint8 operation, uint userID,) = logContract.getLogEntry(logIndex);
        bool consent = agreementContract.checkConsent(dataPurposeHash, userID);
        isCompliant = dataUsageContract.verifyDataPurpose(actorID, userID, operation) && consent;
        emit LogVerificationDetails(logIndex, dataPurposeHash, isCompliant, actorID, operation, userID, consent);
        return isCompliant;
    }
}

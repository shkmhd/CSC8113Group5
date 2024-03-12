// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogContract {
    // Define the operation types as constants
    uint8 constant READ = 0;
    uint8 constant WRITE = 1;
    uint8 constant TRANSFER = 2;

    // Define service names as an enum
    enum ServiceName {
        UserManagement, 
        PaymentProcessing, 
        ContentDelivery, 
        Advertising, 
        SocialNetworking,
        HealthcareDataManagement, 
        EducationalServices, 
        CustomerSupport, 
        SecurityMonitoring,
        InventoryManagement, 
        Logistics, 
        MarketResearch, 
        FinancialServices, 
        LegalDocumentProcessing
    }

    struct LogEntry {
        uint actorID;
        uint8 operation;
        uint userID;
        ServiceName serviceName;
    }

    // Storage for all log entries
    LogEntry[] public logEntries;

    // Event for logging operations
    event LogOperation(
        uint indexed actorID,
        uint8 operation,
        uint indexed userID,
        ServiceName serviceName
    );

    /**
     * @dev Log an operation performed by an actor.
     * @param actorID The ID of the actor performing the operation.
     * @param operation The type of operation (0 for READ, 1 for WRITE, 2 for TRANSFER).
     * @param userID The ID of the user whose data was processed.
     * @param serviceName The enum value of the service within which the operation was performed.
     */
    function logOperation(
        uint actorID,
        uint8 operation,
        uint userID,
        ServiceName serviceName
    ) public {
        require(operation <= TRANSFER, "Invalid operation type.");
        logEntries.push(LogEntry(actorID, operation, userID, serviceName));
        emit LogOperation(actorID, operation, userID, serviceName);
    }

    /**
     * @dev Retrieve a log entry by its index.
     * @param index The index of the log entry in the storage array.
     * @return LogEntry The log entry at the given index.
     */
    function getLogEntry(uint index) public view returns (LogEntry memory) {
        require(index < logEntries.length, "Log entry does not exist.");
        return logEntries[index];
    }
}

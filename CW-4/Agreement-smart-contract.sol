// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Agreement {
    // Event for logging user consent
    event UserConsent(bytes32 indexed dataPurposeHash, uint indexed userId, bool consent);

    struct Consent {
        // Compact the struct to fit in a single 256-bit word to save gas
        bytes32 dataPurposeHash; // 32 bytes
        uint160 userId;         // 20 bytes, assuming userId fits in 160 bits (address size)
        bool consent;           // 1 byte (bool), but will be packed with userId
    }

    // Use a mapping for direct access to consents to save on gas for retrieval operations
    mapping(bytes32 => mapping(uint => bool)) public consents;

    /**
     * @dev Stores or updates the user's consent for a data purpose.
     * @param dataPurposeHash The hash of the data purpose block.
     * @param userId The ID of the user giving consent.
     * @param consent True if consent is positive, false if negative.
     */
    function storeConsent(bytes32 dataPurposeHash, uint userId, bool consent) public {
        require(userId <= type(uint160).max, "userId out of range"); // Ensure userId is within range
        
        consents[dataPurposeHash][userId] = consent;
        emit UserConsent(dataPurposeHash, userId, consent);
    }

    /**
     * @dev Checks the consent given by a user for a specific data purpose.
     * @param dataPurposeHash The hash of the data purpose block.
     * @param userId The ID of the user.
     * @return consent The consent status.
     */
    function checkConsent(bytes32 dataPurposeHash, uint userId) public view returns (bool) {
        require(userId <= type(uint160).max, "userId out of range"); // Ensure userId is within range
        
        return consents[dataPurposeHash][userId];
    }
     
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataUsage {
    enum Operation { Read, Write, Transfer }
    enum ServiceName {
        UserManagement, PaymentProcessing, ContentDelivery, Advertising, SocialNetworking,
        HealthcareDataManagement, EducationalServices, CustomerSupport, SecurityMonitoring,
        InventoryManagement, Logistics, MarketResearch, FinancialServices, LegalDocumentProcessing
    }
    enum ServicePurpose {
        Accounts, Payments, Content, Ads, Networking, Healthcare, Learning, Support,
        Security, Inventory, Shipping, Research, Finance, Legal
    }

    struct UserData {
        uint userID;
        string userName;
        string userAddress;
        uint userPhone;
    }

    struct DataPurpose {
        uint actorID;
        ServiceName serviceName;
        ServicePurpose servicePurpose;
        Operation operation;
        UserData userData;
    }

    DataPurpose[] public dataPurposes;

    function createDataPurpose(
        uint _actorID,
        uint _serviceName,
        uint _operation,
        uint _userID,
        string memory _userName,
        string memory _userAddress,
        uint _userPhone
    ) public {
        UserData memory newUser = UserData({
            userID: _userID,
            userName: _userName,
            userAddress: _userAddress,
            userPhone: _userPhone
        });
      
        dataPurposes.push(DataPurpose({
            actorID: _actorID,
            serviceName: ServiceName(_serviceName),
            servicePurpose: ServicePurpose(_serviceName), // Assuming a direct mapping for simplification
            operation: Operation(_operation),
            userData: newUser
        }));
    }
  function getDataPurpose(uint id) public view returns (DataPurpose memory) {
        require(id < dataPurposes.length, "DataPurpose does not exist.");
        return dataPurposes[id];
    }
    function getDataPurpose2(uint id) public view returns (
        uint actorID,
        string memory serviceName,
        string memory servicePurpose,
        string memory operation,
        UserData memory userData
    ) {
        require(id < dataPurposes.length, "DataPurpose does not exist.");
        DataPurpose storage dataPurpose = dataPurposes[id];

        return (
            dataPurpose.actorID,
            serviceEnumToString(dataPurpose.serviceName),
            purposeEnumToString(dataPurpose.servicePurpose),
            operationEnumToString(dataPurpose.operation),
            dataPurpose.userData
        );
    }

   function serviceEnumToString(ServiceName serviceName) internal pure returns (string memory) {
    if (serviceName == ServiceName.UserManagement) return "User Management";
    else if (serviceName == ServiceName.PaymentProcessing) return "Payment Processing";
    else if (serviceName == ServiceName.ContentDelivery) return "Content Delivery";
    else if (serviceName == ServiceName.Advertising) return "Advertising";
    else if (serviceName == ServiceName.SocialNetworking) return "Social Networking";
    else if (serviceName == ServiceName.HealthcareDataManagement) return "Healthcare Data Management";
    else if (serviceName == ServiceName.EducationalServices) return "Educational Services";
    else if (serviceName == ServiceName.CustomerSupport) return "Customer Support";
    else if (serviceName == ServiceName.SecurityMonitoring) return "Security Monitoring";
    else if (serviceName == ServiceName.InventoryManagement) return "Inventory Management";
    else if (serviceName == ServiceName.Logistics) return "Logistics";
    else if (serviceName == ServiceName.MarketResearch) return "Market Research";
    else if (serviceName == ServiceName.FinancialServices) return "Financial Services";
    else if (serviceName == ServiceName.LegalDocumentProcessing) return "Legal Document Processing";
    else return "Unknown Service Name"; // Default case
}

    function purposeEnumToString(ServicePurpose servicePurpose) internal pure returns (string memory) {
    if (servicePurpose == ServicePurpose.Accounts) return "Accounts";
    else if (servicePurpose == ServicePurpose.Payments) return "Payments";
    else if (servicePurpose == ServicePurpose.Content) return "Content";
    else if (servicePurpose == ServicePurpose.Ads) return "Ads";
    else if (servicePurpose == ServicePurpose.Networking) return "Networking";
    else if (servicePurpose == ServicePurpose.Healthcare) return "Healthcare";
    else if (servicePurpose == ServicePurpose.Learning) return "Learning";
    else if (servicePurpose == ServicePurpose.Support) return "Support";
    else if (servicePurpose == ServicePurpose.Security) return "Security";
    else if (servicePurpose == ServicePurpose.Inventory) return "Inventory";
    else if (servicePurpose == ServicePurpose.Shipping) return "Shipping";
    else if (servicePurpose == ServicePurpose.Research) return "Research";
    else if (servicePurpose == ServicePurpose.Finance) return "Finance";
    else if (servicePurpose == ServicePurpose.Legal) return "Legal";
    else return "Unknown Service Purpose"; // Default case
}

    function operationEnumToString(Operation operation) internal pure returns (string memory) {
        if (operation == Operation.Read) return "Read";
        else if (operation == Operation.Write) return "Write";
        else if (operation == Operation.Transfer) return "Transfer";
        else return "Unknown Operation";
    }

    // function for cross-contract interaction
  
    function verifyDataPurpose(uint _actorID, uint _userID, Operation _operation) external view returns (bool) {
        for (uint i = 0; i < dataPurposes.length; i++) {
            if (dataPurposes[i].actorID == _actorID && dataPurposes[i].userData.userID == _userID && dataPurposes[i].operation == _operation) {
                return true;
            }
        }
        return false;
    }
}

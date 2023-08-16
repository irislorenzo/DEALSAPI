#Author: spalaniappan

@b2c
Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealDiscountStructure = read('../dealDiscountStructure/DealDiscountStructure.json')
    
  
  
  Scenario: Create a discount structure
    Given path 'api/DiscountStructure'
    When request
    """
    {
        "discountStructureId": "e3e2201e-4936-ee11-b8f0-002248971d35",
        "name": "test automation",
        "method": "fixed",
        "amount": 10,
        "discountMap": "1,1,1,1,1,1,1",
        "bookingNight": "1",
        "waiverAdditionalCost": "{\"adults\":1,\"children\":1,\"pets\":1}"
    }
    """
    When method post
    Then status 201
    * match response == {"message":"Discount Structure created successfully."}
    
    
   Scenario: Get discount structure with the discount structure ID
    Given path 'api/DiscountStructure/e3e2201e-4936-ee11-b8f0-002248971d35'
    When method get
    Then status 200
    * match response == DealDiscountStructure
    
   Scenario: Get all the available discount structure
    Given path 'api/DiscountStructure'
    When method get
    Then status 200
    * match response[0] == DealDiscountStructure
    
    Scenario: Update discount structure using discount structure ID
     Given path 'api/DiscountStructure/e3e2201e-4936-ee11-b8f0-002248971d35'
    When request
    """
   {
        "discountStructureId": "e3e2201e-4936-ee11-b8f0-002248971d35",
        "name": "test automation updated",
        "method": "fixed",
        "amount": 10,
        "discountMap": "1,1,1,1,1,1,1",
        "bookingNight": "1",
        "waiverAdditionalCost": "{\"adults\":1,\"children\":1,\"pets\":1}"
    }
    """
    When method put
    Then status 200
    
    
    Scenario: Delete discount structure using discount structure ID
    Given path 'api/DiscountStructure/e3e2201e-4936-ee11-b8f0-002248971d35'
    When method delete
    Then status 200
    
    
  
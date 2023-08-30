#Author: spalaniappan
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
    Then status 204
    
    
  
     Scenario: Send an Invalid request without name field
    Given path 'api/DiscountStructure'
    When request
      """
      {
  "method": "SETPRICE",
  "amount": 10,
  "discountMap": "1,1,1,1,1,1,1",
  "bookingNight": "6,7",
  "waiverAdditionalCost": 1
       }
      """
    When method post
    Then status 400
    * match response.errors == { "name": [  "The Name field is required."  ] }
    
    

    
    
    
     Scenario: Send an Invalid request if method is missing but amount is entered
    Given path 'api/DiscountStructure'
    When request
      """
      {
  "name": "Invalid request if method is missing but amount is entered",
  "amount": 10,
  "discountMap": "1,1,1,1,0,0,0",
  "bookingNight": "4",
  "waiverAdditionalCost": "{\"adults\":2,\"children\":0,\"pets\":0}"
     }
      """
    When method post
    Then status 400
    * string temp = response
    * match temp contains 'Method is required.'
    
    
    
     Scenario: Send an Invalid request if amount is missing but method is entered
    Given path 'api/DiscountStructure'
    When request
      """
      {
  "name": "Invalid request if amount is missing but method is entered",
  "method": "Fixed",
  "discountMap": "1,1,1,1,0,0,0",
  "bookingNight": "1,2,3,4",
  "waiverAdditionalCost": "{\"adults\":2,\"children\":0,\"pets\":0}"
     }
      """
    When method post
    Then status 400
    * string temp = response
    * match temp contains 'Amount is required.'
   
    
   
     Scenario: Send an Invalid request using non unique name
    Given path 'api/DiscountStructure'
    When request
      """
      {
  "name": "Invalid request using non unique name",
  "method": "Setprice",
  "amount": 0,
  "discountMap": "1,1,1,1,1,1,1",
  "bookingNight": "6,7",
  "waiverAdditionalCost": "{\"adults\":2,\"children\":1,\"pets\":1}"
    }
      """
    When method post
    Then status 409
    * string temp = response
    * match temp contains 'A Discount Structure with the same Name already exists.'
    
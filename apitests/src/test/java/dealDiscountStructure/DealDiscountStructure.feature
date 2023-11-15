#Author: spalaniappan
Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealDiscountStructure = read('../dealDiscountStructure/DealDiscountStructure.json')
    * def DealDiscountStructureCreate = read('../dealDiscountStructure/DealDiscountStructureCreate.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
     * def random_string =
 """
 function(s) {
   var text = "";
   var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
   for (var i = 0; i < s; i++)
     text += possible.charAt(Math.floor(Math.random() * possible.length));
   return text;
 }
 """
 * def Name =  random_string(5)

  Scenario: Create a discount structure
  * set DealDiscountStructureCreate.discountStructureId = UUID
  * set DealDiscountStructureCreate.name = Name
    Given path 'api/discount-structure'
    When request DealDiscountStructureCreate
    When method post
    Then status 201
    * match response == {"message":"Discount Structure created successfully."}
  

  #### Get discount structure with the discount structure ID
    #Given path 'api/discount-structure/'+ UUID +''
    #When method get
    #Then status 200
    #* match response == DealDiscountStructure

  ### Get all the available discount structure
    Given path 'api/discount-structure'
    When method get
    Then status 200
    * match response[0] == DealDiscountStructure
      * def UUIDres = response[0].id

  ### Update discount structure using discount structure ID
  * set DealDiscountStructureCreate.name = "test automation- Updated"
    Given path 'api/discount-structure/'+ UUIDres +''
    When request DealDiscountStructureCreate
    When method put
    Then status 200

   ###Delete discount structure using discount structure ID
    #Given path 'api/discount-structure/'+ UUIDres +''
    #When method delete
    #Then status 204

  Scenario: Send an Invalid request without name field
    Given path 'api/discount-structure'
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
    Given path 'api/discount-structure'
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
    Given path 'api/discount-structure'
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
    Given path 'api/discount-structure'
    When request
      """
       {
        "name": "Midweek: 40% Off",
        "method": "percentage",
        "amount": 40.00,
        "discountMap": "1,1,1,1,0,0,0",
        "id": "51175645-21a3-4d8c-9f4b-002e57704e8f"
    }
      """
    When method post
    Then status 409
    * string temp = response
    * match temp contains 'A Discount Structure with the same Name already exists.'

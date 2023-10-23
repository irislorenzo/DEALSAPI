#Author: spalaniappan
Feature: Deal Entity validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDeal.json')
    * def DealSchema = read('../deals/DealSchema.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
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
 * def code =  random_string(5)
 * def Description =  random_string(7)

  Scenario: Deal E2E
    ## Create a Deal Template
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 201
    * match response == {"message":"Deal created successfully."}
    ## Get a Deal Template
    Given path 'api/deals'
    When method get
    Then status 200
    * match response[0] == DealSchema
    ## Get a Deal Template with specific ID
    Given path 'api/deals/'+ UUID +''
    When method get
    Then status 200
    * match response[0] == DealSchema
    ## Update a Deal Template
    * set CreateDeal.description = "Deal Automation-updated"
    Given path 'api/deals/'+ UUID +''
    When request CreateDeal
    When method put
    Then status 200
    * match response == DealSchema
    ## delete a Deal Template
    Given path 'api/deals/'+ UUID +''
    When method delete
    Then status 204

    
   Scenario: Deal conditions validation
   
   ## Create a deal condition
    Given path '/api/deals/78fef5c5-7cf4-4c84-9ced-c2d6a6d6b921/conditions'
    When request
    """
   [{
                "conditionId": "b073703f-b66b-ee11-9938-000d3ad19437",
                "conditionValue": "4"
}]
    """
    When method post
    Then status 201
    * match response == {"message":"Deal Condition(s) created successfully."}
    
    ## Get a deal condition
    Given path '/api/deals/78fef5c5-7cf4-4c84-9ced-c2d6a6d6b921/conditions'
    When method get
    Then status 200
   
   ## Delete a deal condition
   Given path 'api/deals/78fef5c5-7cf4-4c84-9ced-c2d6a6d6b921/conditions/b073703f-b66b-ee11-9938-000d3ad19437'
    When method delete
    Then status 204
    
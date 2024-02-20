#Author: spalaniappan
Feature: Deal Entity validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDealV2.json')
    * def DealSchema = read('../deals/DealSchema.json')
    * def PutDeal = read('../deals/PutDeal.json')
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
    * set CreateDeal.id = UUID
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 201
    And print UUID
    And print Description
    * match response == {"message":"Deal created successfully."}
    
    ## Get a Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def UUIDres = response[0].id
    And print response[0].id
    
    ## Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ UUID +''
    When method get
    Then status 200
    And print UUIDres
    
    ## Update a Deal
    Given path 'api/v2/deals/'+ UUIDres +''
    When request PutDeal
    When method put
    Then status 200

    ## delete a Deal
    Given path 'api/deals/'+ UUIDres +''
    When method delete
    Then status 204
    
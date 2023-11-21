#Author: jeugenio
Feature: Parks Search Negative Validation

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
 
 ## Variables and Path will update once API is stabilized

    Scenario: Post without a CheckIn
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = null
    * set CreateDeal.description = Description
    Given path 'api/deals'
    When request parksSearchSchema
    When method post
    Then status 400
    * match response.errors == {"checkIn":["The CheckIn field is required."]}
    
    Scenario: Post without a CheckOut
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = null
    Given path 'api/deals'
    When request parksSearchSchema
    When method post
    Then status 400
    * match response.errors == {"checkOut":["The CheckOut field is required."]}
    
    Scenario: Post without a Number of Adults
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealStatus = null
    Given path 'api/deals'
    When request parksSearchSchema
    When method post
    Then status 400
    * match response.errors == {"numberOfAdults":["The NumberOfAdults field is required."]} 
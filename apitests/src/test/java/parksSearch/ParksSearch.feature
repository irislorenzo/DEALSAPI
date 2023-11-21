#Author: jeugenio
Feature: Parks Search Validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDeal.json')
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
 
  ## Variables and Path will update once API is stabilized

  Scenario: 
    ## Get Parks Search
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    Given path 'api/deals'
    When request parksSearchSchema
    When method post
    Then status 200
    

    
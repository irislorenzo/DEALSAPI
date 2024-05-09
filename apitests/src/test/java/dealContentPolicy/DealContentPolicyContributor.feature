#Author: spalaniappan
Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealContentPolicy = read('../dealContentPolicy/DealContentPolicy.json')
    * def PutDealContentPolicy = read('../dealContentPolicy/PutDealContentPolicy.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    * def UUID1 = uuid()
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
  * def Name =  random_string(7)
 * def result = call read('classpath:deals/get-token-Contributor-Deals.feature')
 * karate.configure('headers', { 'Authorization': result.token });  
  
   	Scenario: Get All Deal Content Policy
  	#	Get all the available Content policy
    Given path 'api/deal-content-policy'
    When method get
    Then status 200
    
    Scenario: Get Deal Content Policy via ID
  	#	Get deal content first value
    Given path 'api/deal-content-policy/'
    When method get
    Then status 200
    * def dealcontentId = response[0].id
    And print dealcontentId
    Given path 'api/deal-content-policy/' + dealcontentId
    Then status 200
    
    Scenario: Update Deal Content Policy via ID
  	#	Get deal content first value
    Given path 'api/deal-content-policy/'
    When method get
    Then status 200
    * def dealcontentId = response[0].id
    And print dealcontentId   
    Given path 'api/deal-content-policy/' + dealcontentId
    * set PutDealContentPolicy.policyItems[0].value = "variable"
    When request PutDealContentPolicy
    When method PUT
    Then status 403
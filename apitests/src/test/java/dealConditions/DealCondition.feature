#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCondition = read('../dealConditions/dealcondition.json')
    * def dealConditionCreate = read('../dealConditions/dealConditionCreate.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def dealConditionExpected = read('../dealConditions/dealConditionExpected2.json')
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
 * def result = call read('classpath:deals/get-token-Admin-Deals.feature')
 * karate.configure('headers', { 'Authorization': result.token });
 
   Scenario: Get All Condition 
 
    # Get all the available conditons
    Given path 'api/Conditions'
    When method get
    Then status 200
    And def dealConditionRespone = dealConditionExpected
    And print response
    And print dealConditionExpected
    * match response == dealConditionExpected

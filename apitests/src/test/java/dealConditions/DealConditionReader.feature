#Author: jeugenio
Feature: Deal Condition Entity validation Reader Role

  Background: 
    * url dealsUrl
    * def dealCondition = read('../dealConditions/dealcondition.json')
    * def dealConditionCreate = read('../dealConditions/dealConditionCreate.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def dealConditionExpected = read('../dealConditions/dealConditionExpected2.json')
 * def result = call read('classpath:deals/get-token-Reader-Deals.feature')
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

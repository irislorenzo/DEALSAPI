#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url parksUrl
    * def ParksSchema = read('../parks/parksSchema.json')
    
    
  Scenario: Get all parks information
  
  Given path 'parks'
  When method get
  Then status 200
  * match response.parks.[0] == ParksSchema


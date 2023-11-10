#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url parksUrl
    * def ParksSchema = read('../parks/parksSchema.json')
    * def ParksAccomodationSchema = read('../parks/parksAccommodationSchema.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    * def result = call read('classpath:parks/get-token-Parks.feature')
    * karate.configure('headers', { 'Authorization': result.token });
  
    
    
    
  Scenario: Get all parks information
  
  Given path 'api/parks'
  When method get
  Then status 200
  * match response.parks.[0] == ParksSchema

  Scenario: Get parks information by park ID
  Park ID will be static for now and will update once creation of park ID endpoint is also created
  
  Given path '/api/parks/' + "WLAN" +''
  When method get
  Then status 200
  * match response == ParksSchema
  
  Scenario: Get accommodations information for park
 
  Given path '/api/parks/' + "WLAN" + '/accommodations' 
  When method get
  Then status 200
  * match response[0] == ParksAccomodationSchema
  
  Scenario: Get all parks accommodations information
  
  Given path 'api/parks-accommodations'
  When method get
  Then status 200
  
  
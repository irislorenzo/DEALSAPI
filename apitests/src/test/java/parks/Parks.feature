#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url parksUrl
    * def ParksSchema = read('../parks/parksSchema2.json')
    * def ParksAccomodationSchema = read('../parks/parksAccommodationSchema2.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    * def result = call read('classpath:parks/get-token-Parks.feature')
    * karate.configure('headers', { 'Authorization': result.token });

  Scenario: Get all parks information
  
  Given path 'api/parks'
  When method get
  Then status 200
  * match response.parks[0] == ParksSchema

  Scenario: Get parks information by park ID
  Park ID will be static for now and will update once creation of park ID endpoint is also created
  
  Given path '/api/parks/' + "WLAN" +''
  When method get
  Then status 200
  * match response == ParksSchema
  
  Scenario: Get accommodations information for specific park
 
  Given path '/api/parks/' + "WLAN" + '/accommodations' 
  When method get
  Then status 200
  * match response[0].detail == ParksAccomodationSchema
  
  Scenario: Get all parks accommodations information
  
  Given path 'api/parks-accommodations'
  When method get
  Then status 200
  
  Scenario: Get parks accommodations content
  
  Given path '/api/parks/' + "WLAN" + '/accommodations' 
  When method get
  Then status 200
  * match response[*].accommodationId contains ["WLAN-OTAV2-329-RT"]
  
  Scenario: Get parks accommodations content with invalid accommodation
  
  Given path '/api/parks/' + "WLAN" + '/accommodations' 
  When method get
  Then status 200
  * match response[*].accommodationId !contains ["INVALID_ACCOMMODATION"]
  
  Scenario: GET parks using parkCode and accommodationId
  
  Given path '/api/parks/' + "WLAN" + '/accommodations/' + 'WLAN-OTAV2-329-RT' 
  When method get
  Then status 200
  * match response.accommodationId contains "WLAN-OTAV2-329-RT"
  
  Scenario: GET parks using parkCode and verify if isFeatured is displayed
  
  Given path '/api/parks/' + "WLAN" + '/accommodations'  
  When method get
  Then status 200
  #Not featured means no value on object
  * match response[*].isFeatured == []
  
  Scenario: GET parks SEE and DO
  
  Given path '/api/parks/' + "WLAN" + '/see-and-do'  
  When method get
  Then status 200  
  
  Scenario: GET parks SEE and DO using non-existing parkCode
  
  Given path '/api/parks/' + "DDDD" + '/see-and-do'  
  When method get
  Then status 404    

  Scenario: Verify that parkCode is required in GET parks SEE and DO 
  
  Given path '/api/parks/' + "" + '/see-and-do'  
  When method get
  Then status 404   
  
  
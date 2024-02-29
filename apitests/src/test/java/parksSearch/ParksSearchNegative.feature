#Author: jeugenio
Feature: Parks Search Negative Validation

  Background: 
    * url parkSearchUrl
    * def GetParks = read('../parksSearch/parksSearchSchema.json')
    * def result = call read('classpath:parksSearch/get-token-ParksSearch.feature')
    * karate.configure('headers', { 'Authorization': result.token });    

    Scenario: Get without required fields - CheckIn, CheckOut, and NumberOfAdults
    Given path 'api/search/parks'
    When method get
    Then status 424
    
    Scenario: Park Search date more than 28 days
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-29'
    Given path 'api/search/parks'
    When method get
    Then status 400
    * match response == ["If you require a booking for 28 days or more, you will need to contact the park directly. Please send us an email with your booking requirements or call on (08) 8449 7726."]
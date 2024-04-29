#Author: jeugenio
Feature: Dynamic Offer Negative Test Validation

  Background: 
    * url dynamicOfferUrl
    * def DynamicOffer = read('../dynamicOffer/DynamicOffer.json')
    * def result = call read('classpath:dynamicOffer/get-token-DynamicOffer.feature')
    * karate.configure('headers', { 'Authorization': result.token });

  Scenario: GET Dynamic Offer without Kids field   
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = null
    * param Infants = 0
    Given path '/offers/'
    When method GET   
    Then status 400     
    * match response.errors == {"kids":["The Kids field is required."]}
    
  Scenario: GET Dynamic Offer without Adults field   
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET   
    Then status 400        
    * match response.errors == {"adults":["The Adults field is required."]}
    
  Scenario: GET Dynamic Offer without Infants field   
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    Given path '/offers/'
    When method GET   
    Then status 400        
    * match response.errors == {"infants":["The Infants field is required."]}
    
  Scenario: GET Dynamic Offer without Arrive field   
    * param PropertyCode = 'TEST'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET   
    Then status 400        
    * match response.errors == {"arrive.Arrive":["The Arrive field is required."]}     
    
  Scenario: Post Dynamic Offer without Depart field    
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET   
    Then status 400        
    * match response.errors == {"depart.Depart":["The Depart field is required."]}   
    
    Scenario: GET Dynamic Offer without Property Code field    
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET   
    Then status 400     
    * match response.errors == {"propertyCode":["The PropertyCode field is required."]} 
    
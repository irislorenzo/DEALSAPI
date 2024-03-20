#Author: jeugenio
Feature: Dynamic Offer View Conditions Of a Deal

  Background: 
    * url dynamicOfferUrl
    * def DynamicOfferViewConditions = read('../dynamicOfferViewConditionsOfDeal/DynamicOfferViewConditionsOfDeal.json')

  Scenario: Verify Booking Date Range Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'bookingDateRangeCondition'

  Scenario: Verify Stay Date Range Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'stayDateRangeCondition'     

  Scenario: Verify Check-In Days Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'checkInDaysCondition'         
  
  Scenario: Verify Accommodation Inclusion Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'accommodationInclusionCondition'     
  
  Scenario: Verify Discount Structure Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'discountStructureCondition'  
  
  Scenario: Verify Advance Booking Day Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'advanceBookingDaysCondition'   
  
  Scenario: Verify Maximum Night Stay Condition
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2025-01-01'
    * param Depart = '2025-01-05'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path '/offers/'
    When method GET
    Then status 200
  	* match response.offerItems[*].deal.eligibility.conditions[*].conditionCode contains 'maximumNightStayCondition'      
              
    
   
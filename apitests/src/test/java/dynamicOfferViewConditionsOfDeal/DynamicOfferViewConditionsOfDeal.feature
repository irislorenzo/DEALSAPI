#Author: jeugenio
Feature: Dynamic Offer View Conditions Of a Deal

  Background: 
    * url dynamicOfferUrl
    * def DynamicOfferViewConditions = read('../dynamicOfferViewConditionsOfDeal/DynamicOfferViewConditionsOfDeal.json')

  Scenario: Verify Booking Date Range Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'bookingDateRangeCondition'

  Scenario: Verify Stay Date Range Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'stayDateRangeCondition'  

  Scenario: Verify Check-In Days Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'checkInDaysCondition'
  
  Scenario: Verify Accommodation Inclusion Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'accommodationInclusionCondition'
  
  Scenario: Verify Discount Structure Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'discountStructureCondition'
  
  Scenario: Verify Advance Booking Day Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'advanceBookingDaysCondition'
  
  Scenario: Verify Maximum Night Stay Condition
    
  When request DynamicOfferViewConditions
  When method post
  Then status 200     
  * match response.offersGroup.parkOffers[*].accommodationOffers[*].offers[*].offerItems[*].eligibility.conditions[*].conditionCode contains 'maximumNightStayCondition'
              
    
   
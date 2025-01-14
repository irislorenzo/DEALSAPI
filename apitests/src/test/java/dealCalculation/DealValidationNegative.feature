#Author: jeugenio
Feature: Deal Validation Negative

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')
    * def result = call read('classpath:dealCalculation/get-token-DealCalculation.feature')
    * karate.configure('headers', { 'Authorization': result.token });

    Scenario: Verify CheckOut date > CheckIn date
    # Get Deal Validation
    * set CreateDealValidation.Booking.CheckInDate = "2024-12-31T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify CheckOut date > CheckIn date
    # Get Deal Validation
    * set CreateDealValidation.Booking.CheckOutDate = "2023-10-19T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify NULL ParkCode input
     Get Deal Validation
    * set CreateDealValidation.ParkCode = null

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"ParkCode":["The ParkCode field is required.", "The specified park code is invalid"]}  
	
		Scenario: Verify Booking Date Range condition
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[0].code == "BookingDateRangeCondition"
  
		Scenario: Verify Stay Date Range condition
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[1].code == "StayDateRangeCondition"

		Scenario: Verify CheckIn Date Range condition
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[2].code == "CheckInDaysCondition"
  * match response.accommodationDeals[0].deals[0].conditions[2].message == "Check-in days needs to be Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday" 

		Scenario: Verify Blackout Date Range condition
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[3].code == "BlackOutDateRangeCondtition"
  * match response.accommodationDeals[0].deals[0].conditions[*].satisfied contains true 	
  
		Scenario: Verify Accommodation Inclusion condition (All)
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[4].code == "AccommodationInclusionCondition"
  * match response.accommodationDeals[0].deals[0].conditions[4].message == "Applies to accommodations of type All"
  
		Scenario: Verify Discount Structure condition
    * set CreateDealValidation.ParkCode = "QKIL"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200    	
  * match response.accommodationDeals[0].deals[0].conditions[5].code == "DiscountStructureCondition"
  * match response.accommodationDeals[0].deals[0].conditions[5].message == "Discount rate only received on Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"  
						 	    		
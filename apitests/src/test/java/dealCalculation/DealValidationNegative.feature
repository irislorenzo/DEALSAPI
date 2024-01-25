#Author: jeugenio
Feature: Deal Validation Negative

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')

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
  * match response.accommodationDeals[0].deals[0].conditions[1].message == "Stay dates needs to be from 01 Mar 2024 and 02 Mar 2025"

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
  * match response.accommodationDeals[0].deals[0].conditions[3].message == "Booking must not be in the range, Date from 30 Jan 2024 to 31 Jan 2024" 	
  
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
						 	    		
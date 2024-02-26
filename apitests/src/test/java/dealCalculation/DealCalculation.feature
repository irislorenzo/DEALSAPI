#Author: jeugenio
Feature: Deal Calculation

  Background: 
    * url dealCalcUrl
    * def CreateDealCalculation = read('../dealCalculation/CreateDealCalculation.json')

    Scenario: Verify Additional Waiver not applied
    # Get Deal Validation
    * set CreateDealCalculation.Booking.CheckInDate = "2025-02-05T00:00:00Z"
    * set CreateDealCalculation.Booking.CheckOutDate = "2025-02-09T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealCalculation
    When method post
    Then status 200
	  * match response.accommodationDeals[*].deals[*].pricing[0].isAdditionalChargeRemoved == [false]
	
    Scenario: Verify Additional Waiver applied
    # Get Deal Validation
    * set CreateDealCalculation.Booking.CheckInDate = "2025-02-05T00:00:00Z"
    * set CreateDealCalculation.Booking.CheckOutDate = "2025-02-09T00:00:00Z"
    * set CreateDealCalculation.Booking.NumberOfAdults = "3"
    * set CreateDealCalculation.Booking.NumberOfChildren = "1"
    * set CreateDealCalculation.Booking.NumberOfPets = "1"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealCalculation
    When method post
    Then status 200
	  * match response.accommodationDeals[*].deals[*].pricing[0].isAdditionalChargeRemoved == [true]		

    Scenario: Verify additional charges removal when Booking nights count is equals to Booking nights rule
    # Get Deal Validation
    * set CreateDealCalculation.Booking.CheckInDate = "2025-02-05T00:00:00Z"
    * set CreateDealCalculation.Booking.CheckOutDate = "2025-02-06T00:00:00Z"
    * set CreateDealCalculation.Booking.NumberOfAdults = "3"
    * set CreateDealCalculation.Booking.NumberOfChildren = "1"
    * set CreateDealCalculation.Booking.NumberOfPets = "1"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealCalculation
    When method post
    Then status 200
	  * match response.accommodationDeals[*].deals[*].pricing[0].isDealApplied == [true]	
	  
    Scenario: Verify Base Rate Amount For Two Adults
    # Get Deal Validation
    * set CreateDealCalculation.Booking.CheckInDate = "2025-02-05T00:00:00Z"
    * set CreateDealCalculation.Booking.CheckOutDate = "2025-02-06T00:00:00Z"
    * set CreateDealCalculation.Booking.NumberOfAdults = "2"
    * set CreateDealCalculation.Booking.NumberOfChildren = "0"
    * set CreateDealCalculation.Booking.NumberOfPets = "0"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealCalculation
    When method post
    Then status 200
	  * match response.accommodationDeals[*].deals[*].pricing[0].baseRateAmountForTwoAdults == [10]
						 	    		
#Author: jeugenio
Feature: Deal Validation Negative

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')

    Scenario: Verify CheckOut date > CheckIn date
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckInDate = "2024-12-31T00:00:00Z"

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify CheckOut date > CheckIn date
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckOutDate = "2023-10-19T00:00:00Z"

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify NULL ParkCode input
    ## Get Deal Validation
    * set CreateDealValidation.ParkCode = null

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"ParkCode":["The ParkCode field is required.", "The specified park code is invalid"]}         
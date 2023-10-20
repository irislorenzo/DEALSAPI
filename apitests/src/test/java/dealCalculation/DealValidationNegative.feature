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
	
	Scenario: Verify No pricing data
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckInDate = "2025-10-15T00:00:00Z"
    * set CreateDealValidation.Booking.CheckOutDate = "2025-10-16T00:00:00Z"

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200
	* match response.accommodationDeals[0].deals[0].message == "Pricing data not found."  	
	
	Scenario: Verify Deal outside Booking Date Range
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request 
    """
{
    "ParkCode": "VNAT",
    "Booking": {
        "CheckInDate": "2023-10-15T00:00:00Z",
        "CheckOutDate": "2023-10-16T00:00:00Z",
        "NumberOfAdults": 2,
        "NumberOfChildren": 5,
        "NumberOfPets": 0
    },
    "AccommodationPricing": [
        {
            "AccommodationId": "VNAT-3008-23-RT",
            "AccommodationType": 1,
            "totalPrice": 1500,
            "PriceBreakdown": [
                {
                    "Date": "2023-10-15T00:00:00Z",
                    "BaseRateAmountForTwoAdults": 250,
                    "AdditionalAdultAmount": 15,
                    "ChildAmount": 10,
                    "PetAmount": 5
                },
                {
                    "Date": "2023-10-16T00:00:00Z",
                    "BaseRateAmountForTwoAdults": 250,
                    "AdditionalAdultAmount": 15,
                    "ChildAmount": 10,
                    "PetAmount": 5
                }		
            ]
        }
    ]
}
    """
    When method post
    Then status 200
	* match response.accommodationDeals[0].deals[0].message == "Booking Dates are outside the Deal Stay date range: 10/18/2023 12:00:00 AM +00:00 → 12/31/2024 11:59:59 PM +00:00"  		
	
	Scenario: Verify Deal inside Blackout Date Range
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request 
        """
{
    "ParkCode": "VNAT",
    "Booking": {
        "CheckInDate": "2023-12-30T00:00:00Z",
        "CheckOutDate": "2023-12-31T00:00:00Z",
        "NumberOfAdults": 2,
        "NumberOfChildren": 5,
        "NumberOfPets": 0
    },
    "AccommodationPricing": [
        {
            "AccommodationId": "VNAT-3008-23-RT",
            "AccommodationType": 1,
            "totalPrice": 1500,
            "PriceBreakdown": [
                {
                    "Date": "2023-12-30T00:00:00Z",
                    "BaseRateAmountForTwoAdults": 250,
                    "AdditionalAdultAmount": 15,
                    "ChildAmount": 10,
                    "PetAmount": 5
                }		
            ]
        }
    ]
}
    """      
    When method post
    Then status 200
	* match response.accommodationDeals[0].deals[0].message == "Booking Dates are within Deal Blackout date range: 12/30/2023 12:00:00 AM +00:00 → 12/31/2023 11:59:59 PM +00:00" 			
#Author: jeugenio
Feature: Deal Validation Negative

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')

    Scenario: Verify CheckOut date > CheckIn date
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckInDate = "2024-12-31T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify CheckOut date > CheckIn date
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckOutDate = "2023-10-19T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"Booking":["The check out date should be later than the check in date"]}
	
	Scenario: Verify NULL ParkCode input
    ## Get Deal Validation
    * set CreateDealValidation.ParkCode = null

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 400
	* match response.errors == {"ParkCode":["The ParkCode field is required.", "The specified park code is invalid"]}         
	
	Scenario: Verify No pricing data
    ## Get Deal Validation
    * set CreateDealValidation.Booking.CheckInDate = "2025-10-15T00:00:00Z"
    * set CreateDealValidation.Booking.CheckOutDate = "2025-10-16T00:00:00Z"

    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200
	* match response.accommodationDeals[0].deals[0].message == "Pricing data not found."  	
	
	Scenario: Verify Deal outside Booking Date Range
    ## Get Deal Validation

    Given path 'api/accommodations/calculate-deals'
    When request 
    """
{
    "ParkCode": "TEST",
    "Booking": {
        "CheckInDate": "2026-01-15T00:00:00Z",
        "CheckOutDate": "2026-01-16T00:00:00Z",
        "NumberOfAdults": 2,
        "NumberOfChildren": 5,
        "NumberOfPets": 0
    },
    "AccommodationPricing": [
        {
            "AccommodationId": "TEST-3008-23-RT",
            "AccommodationType": 1,
            "totalPrice": 1500,
            "PriceBreakdown": [
                {
                    "Date": "2026-01-15T00:00:00Z",
                    "BaseRateAmountForTwoAdults": 250,
                    "AdditionalAdultAmount": 15,
                    "ChildAmount": 10,
                    "PetAmount": 5
                },
                {
                    "Date": "2026-01-16T00:00:00Z",
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
	* match response.accommodationDeals[0].deals[0].message == "Booking Dates are outside the Deal Stay date range: 1/2/2023 12:00:00 AM +00:00 → 12/31/2025 12:00:00 AM +00:00"  		

## Will update scenarios below when test data are available
	
#	Scenario: Verify Deal inside Blackout Date Range
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "SADO",
    #"Booking": {
        #"CheckInDate": "2028-10-29T23:59:59Z",
        #"CheckOutDate": "2028-11-01T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "SADO-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2028-10-29T23:59:59Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200
#	* match response.accommodationDeals[0].deals[0].message == "Booking Dates are within Deal Blackout date range: 12/30/2023 12:00:00 AM +00:00 → 12/31/2023 11:59:59 PM +00:00"
#	
#	Scenario: Verify Deal Check In is on Monday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-05T00:00:00Z",
        #"CheckOutDate": "2024-02-06T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-05T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Monday"
#	
#	Scenario: Verify Deal Check In is on Tuesday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-06T00:00:00Z",
        #"CheckOutDate": "2024-02-07T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-06T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Tuesday"
#	
#	Scenario: Verify Deal Check In is on Wednesday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-07T00:00:00Z",
        #"CheckOutDate": "2024-02-08T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-07T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Wednesday"
#	
#	Scenario: Verify Deal Check In is on Thursday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-08T00:00:00Z",
        #"CheckOutDate": "2024-02-09T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-08T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Thursday"
#	
#	Scenario: Verify Deal Check In is on Friday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-09T00:00:00Z",
        #"CheckOutDate": "2024-02-10T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-09T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Friday"
#	
#	Scenario: Verify Deal Check In is on Saturday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-10T00:00:00Z",
        #"CheckOutDate": "2024-02-11T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-10T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal does not apply to Bookings where Check In is on a Saturday"
#	
#	Scenario: Verify Deal Check In is on Sunday
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "SADO",
    #"Booking": {
        #"CheckInDate": "2024-02-11T00:00:00Z",
        #"CheckOutDate": "2024-02-12T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "SADO-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-11T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[1].message == "Deal does not apply to Bookings where Check In is on a Sunday"
#	
#	Scenario: Verify Deal Accommodation Validation when Accommodation Type is Site
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-11T00:00:00Z",
        #"CheckOutDate": "2024-02-12T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 1,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-11T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[0].message == "Deal is not applicable for Accommodation selected: Deal Accomodation Type Included Site "
#	
#	Scenario: Verify Deal Accommodation Validation when Accommodation Type is Cabin
    ## Get Deal Validation
#
    #Given path 'api/accommodations/calculate-deals'
    #When request 
        #"""
#{
    #"ParkCode": "QSUN",
    #"Booking": {
        #"CheckInDate": "2024-02-05T00:00:00Z",
        #"CheckOutDate": "2024-02-06T00:00:00Z",
        #"NumberOfAdults": 2,
        #"NumberOfChildren": 5,
        #"NumberOfPets": 0
    #},
    #"AccommodationPricing": [
        #{
            #"AccommodationId": "QSUN-3008-23-RT",
            #"AccommodationType": 2,
            #"totalPrice": 1500,
            #"PriceBreakdown": [
                #{
                    #"Date": "2024-02-05T00:00:00Z",
                    #"BaseRateAmountForTwoAdults": 250,
                    #"AdditionalAdultAmount": 15,
                    #"ChildAmount": 10,
                    #"PetAmount": 5
                #}		
            #]
        #}
    #]
#}
    #"""      
    #When method post
    #Then status 200	
#	* match response.accommodationDeals[0].deals[1].message == "Deal is not applicable for Accommodation selected: Deal Accomodation Type Included Cabin "							 	    		
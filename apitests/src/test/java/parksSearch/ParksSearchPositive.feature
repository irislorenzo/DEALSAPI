#Author: jeugenio
Feature: Parks Search Positive Validation

  Background: 
    * url parkSearchUrl
    * def GetParks = read('../parksSearch/parksSearchSchema.json')

    Scenario: Get using required fields - CheckIn, CheckOut, and NumberOfAdults
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    Given path 'api/search/parks'
    When method get
    Then status 200
    
    Scenario: Get using lat and long
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param lat = -15.574689
    * param lng = 133.216206
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].latitude == -15.574689
    * match response.parks[0].longitude == 133.216206
    
    Scenario: Get using State
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param states = 'QLD'
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].state == 'QLD'

    Scenario: Get using Experiences
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param experiences = 'Golfing'
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].experiences[*] contains "Golfing"
    
    Scenario: Get using Features
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param features = 'Laundry'
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].features[*] contains "Laundry"
    
    Scenario: Get when PetsAllowed is set to True
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param petsAllowed = true
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].restrictions[0].displayName == "Dogs Allowed"
    
    Scenario: Get when PetsAllowed is set to False
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param petsAllowed = false
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].restrictions[0].displayName == "No Dogs Allowed"
      
    Scenario: Get using ParkBrand
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param parkBrand = "Discovery Parks"
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.parks[0].parkBrands[0] == "Discovery Parks"
    
    Scenario: Get using PageSize
    * param checkIn = '2023-12-01'
    * param checkOut = '2023-12-28'
    * param numberOfAdults = 2
    * param pageSize = 4
    Given path 'api/search/parks'
    When method get
    Then status 200
    * match response.pageSize == 4

#Author: jeugenio
Feature: Deal Validation Positive

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')
 
    Scenario: Verify Auto $99 Cabins Calculation
    ## Get Deal Validation
    
    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200     
    * match response.accommodationDeals[0].deals[0].dealCode == "AUTO $99 Cabins"
    * match response.accommodationDeals[0].deals[0].isDealApplied == true
    * match response.accommodationDeals[0].deals[0].totalPrice == 894   

    Scenario: Verify Stay 7, Pay 6 Deal Calculation
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200 
    * match response.accommodationDeals[0].deals[1].dealCode == "AUTO Stay 7, Pay 6"
    * match response.accommodationDeals[0].deals[1].isDealApplied == false
    * match response.accommodationDeals[0].deals[1].totalPrice == 1800       

    Scenario: Verify Stay Kids for Free Deal Calculation
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200 
    * match response.accommodationDeals[0].deals[2].dealCode == "AUTO Stay Kids for Free"
    * match response.accommodationDeals[0].deals[2].isDealApplied == true
    * match response.accommodationDeals[0].deals[2].totalPrice == 594   
    
    Scenario: Verify Stay 5, Pay 3 Deal Calculation
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200    
    * match response.accommodationDeals[0].deals[3].dealCode == "AUTO Stay 5, Pay 3"
    * match response.accommodationDeals[0].deals[3].isDealApplied == true
    * match response.accommodationDeals[0].deals[3].totalPrice == 1498

    Scenario: Verify Stay 2, Save 20% Deal Calculation
    ## Get Deal Validation

    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200
    * match response.accommodationDeals[0].deals[4].dealCode == "AUTO Stay 2, Save 20%"
    * match response.accommodationDeals[0].deals[4].isDealApplied == true
    * match response.accommodationDeals[0].deals[4].totalPrice == 1440

    Scenario: Verify 20% Midweek Deal Calculation
    ## Get Deal Validation
    
    Given path 'api/accommodations/deals'
    When request CreateDealValidation
    When method post
    Then status 200
    * match response.accommodationDeals[0].deals[5].dealCode == "AUTO 20% Off Midweek"
    * match response.accommodationDeals[0].deals[5].isDealApplied == false
    * match response.accommodationDeals[0].deals[5].totalPrice == 1560
     
#Author: jeugenio
Feature: Dynamic Offer Positive Test Validation

  Background: 
    * url dynamicOfferUrl
    * def DynamicOffer = read('../dynamicOffer/DynamicOffer.json')

  Scenario: Verify Base Offer on Deal
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path null
    When method GET
    Then status 200     
    * match response.offerItems[*].offerTemplateCode contains "baseOffer"
    
  Scenario: Verify Member Offer on Deal

    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path null
    When method GET
    Then status 200     
    * match response.offerItems[*].offerTemplateCode contains "memberOffer"

  Scenario: Verify Deal Offer on Deal

    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path null
    When method GET
    Then status 200     
    * match response.offerItems[*].offerTemplateCode contains "dealOffer"
    
    
    ##Offer Store
    Scenario: Verify Dynamic offer offer store
    
    * param PropertyCode = 'TEST'
    * param Arrive = '2024-05-08'
    * param Depart = '2024-05-10'
    * param Adults = 2
    * param Kids = 0
    * param Infants = 0
    Given path null
    When method GET
    Then status 200
    * def shoppingID = response.shoppingResponseRefID
    
    ## valid shopping ID
    When path ''+ shoppingID +''
    When method get
    Then status 200 
    
    ##Invalid shopping ID
    When path 'b4362cf4-6ce4-4a98-89c3-8a66e76fecd7'
    When method get
    Then status 404
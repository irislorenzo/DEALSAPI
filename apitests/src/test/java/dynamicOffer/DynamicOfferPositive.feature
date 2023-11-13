#Author: jeugenio
Feature: Dynamic Offer Positive Test Validation

  Background: 
    * url dynamicOfferUrl
    * def DynamicOffer = read('../dynamicOffer/DynamicOffer.json')

  Scenario: Verify Base Offer on Deal
    
    When request DynamicOffer
    When method post
    Then status 200     
    * match response.offersGroup.parkOffers[0].accommodationOffers[0].offers[0].offerTemplateCode == "baseOffer"
    
  Scenario: Verify Member Offer on Deal

    When request DynamicOffer
    When method post
    Then status 200     
    * match response.offersGroup.parkOffers[0].accommodationOffers[0].offers[1].offerTemplateCode == "memberOffer"    

  Scenario: Verify Deal Offer on Deal

    When request DynamicOffer
    When method post
    Then status 200     
    * match response.offersGroup.parkOffers[0].accommodationOffers[0].offers[2].offerTemplateCode == "dealOffer"  
    
    
    ###Offer Store
    Scenario: Verify Dynamic offer offer store
    
    When request DynamicOffer
    When method post
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
#Author: jeugenio
Feature: Dynamic Offer Negative Test Validation

  Background: 
    * url dynamicOfferUrl
    * def DynamicOffer = read('../dynamicOffer/DynamicOffer.json')

  Scenario: Post Dynamic Offer without Kids field   
    When request 
    """
{
   "accommodationRequest": {
    "propertyCode": "TEST",
    "accommodationType": "cabin",
    "arrive": "2024-01-08",
    "depart": "2024-01-10",
    "adults": 2,
    "Infants":0,
    "promocode":"15DollarOff749"
  }
}
    """    
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.Kids":["The Kids field is required."]}
    
  Scenario: Post Dynamic Offer without Adults field   
    When request 
    """
{
   "accommodationRequest": {
    "propertyCode": "TEST",
    "accommodationType": "cabin",
    "arrive": "2024-01-08",
    "depart": "2024-01-10",
    "kids": 2,
    "Infants":0,
    "promocode":"15DollarOff749"
  }
}
    """    
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.Adults":["The Adults field is required."]} 
    
  Scenario: Post Dynamic Offer without Infants field   
    When request 
    """
{
   "accommodationRequest": {
    "propertyCode": "TEST",
    "accommodationType": "cabin",
    "arrive": "2024-01-08",
    "depart": "2024-01-10",
    "adults": 2,
    "kids": 2,
    "promocode":"15DollarOff749"
  }
}
    """   
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.Infants":["The Infants field is required."]}          
    
  Scenario: Post Dynamic Offer without Arrive field   
    When request 
    """
{
   "accommodationRequest": {
    "propertyCode": "TEST",
    "accommodationType": "cabin",
    "depart": "2024-01-10",
    "adults": 2,
    "kids": 2,
    "Infants":0,
    "promocode":"15DollarOff749"
  }
}
    """    
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.Arrive":["The Arrive field is required."]}       
    
  Scenario: Post Dynamic Offer without Depart field    
    When request 
    """
{
   "accommodationRequest": {
    "propertyCode": "TEST",
    "accommodationType": "cabin",
    "arrive": "2024-01-10",
    "adults": 2,
    "kids": 2,
    "Infants":0,
    "promocode":"15DollarOff749"
  }
}
    """    
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.Depart":["The Depart field is required."]}   
    
    Scenario: Post Dynamic Offer without Property Code field    
    When request 
    """
{
   "accommodationRequest": {
    "accommodationType": "cabin",
    "arrive": "2024-01-08",
    "depart": "2024-01-10",
    "adults": 2,
    "kids": 2,
    "Infants":0,
    "promocode":"15DollarOff749"
  }
}
    """    
    When method post
    Then status 400     
    * match response.errors == {"accommodationRequest.PropertyCode":["The PropertyCode field is required."]}   
    
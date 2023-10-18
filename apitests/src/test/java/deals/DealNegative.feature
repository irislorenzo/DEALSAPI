#Author: jeugenio
Feature: Deal Entity negative validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDeal.json')
    * def DealSchema = read('../deals/DealSchema.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
     * def UUID = uuid()
        * def random_string =
 """
 function(s) {
   var text = "";
   var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
   for (var i = 0; i < s; i++)
     text += possible.charAt(Math.floor(Math.random() * possible.length));
   return text;
 }
 """
 * def code =  random_string(5)
 * def Description =  random_string(7)

    Scenario: Create a deal without a Code
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = null
    * set CreateDeal.description = Description
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"code":["The Code field is required."]}
    
    Scenario: Create a deal without a Description
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"description":["The Description field is required."]}
    
    Scenario: Create a deal without a Deal Status
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealStatus = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"dealStatus":["The DealStatus field is required."]}

    Scenario: Create a deal without a Deal Type
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealType = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"dealType":["The DealType field is required."]}

    Scenario: Create a deal with a Deal Type incorrect enum value
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealType = "invalid"
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400

    Scenario: Create a deal without a Park Code
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.parkCode = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"parkCode":["The ParkCode field is required."]}
    
    Scenario: Create a deal with Past Dates on publishDateTime and withdrawalDateTime
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.publishDateTime = "2022-09-30T01:43:05.11"
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.[0].errorMessage == "Publish date and Withdrawal date should not be in the past."
    
    Scenario: Create a deal without Check In Days
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.checkInDays = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"checkInDays":["The CheckInDays field is required."]}
    
    Scenario: Create a deal without Accommodation Inclusion Condition
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.accommodationInclusionCondition = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"accommodationInclusionCondition":["The AccommodationInclusionCondition field is required."]}
    
    Scenario: Create a deal with Accommodation Inclusion Condition incorrect enum value
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.accommodationInclusionCondition = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"accommodationInclusionCondition":["The AccommodationInclusionCondition field is required."]}  
    
    Scenario: Create a deal without Deal Approval Status
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealApprovalStatus = null
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"dealApprovalStatus":["The DealApprovalStatus field is required."]}        
    
    Scenario: Create a deal with an existing Code
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 201
    
    ##Create a Deal again with the same code
    Given path 'api/deals'
    When request CreateDeal
    When method post
    Then status 400
    
    * match response == [{"propertyName":"Code","errorMessage":"The specified Code already exists.","severity":"error"}]             
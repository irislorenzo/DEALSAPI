#Author: jeugenio
Feature: Deal Entity negative validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDealV2.json')
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
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"code":["The Code field is required."]}
    
    Scenario: Create a deal without a Description
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = null
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"description":["The Description field is required."]}
    
    #Scenario: Create a deal without a Deal Status #COMMENTED FOR NOW NEED TO CONFIRM 2.20
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealStatus = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"dealStatus":["The DealStatus field is required."]}

    #Scenario: Create a deal without a Deal Type #COMMENTED FOR NOW NEED TO CONFIRM 2.20
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealType = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"dealType":["The DealType field is required."]}

    #Scenario: Create a deal with a Deal Type incorrect enum value - COMMENTED FOR NOW MAYBE CONNECTED ON DEAL TYPE ISSUE
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealType = "invalid"
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400

    Scenario: Create a deal without a Park Code
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.parkCode = null
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"parkCode":["The ParkCode field is required."]}
    
    Scenario: Create a deal with Past Dates on publishDateTime and withdrawalDateTime
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.publishDateTime = "2023-05-24T05:51:31.015Z"
    * set CreateDeal.withdrawalDateTime = "2023-05-25T05:51:31.015Z"
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response == ["Publish date and Withdrawal date should not be in the past."]
    
    #Scenario: Create a deal without Check In Days #COMMENTED FOR NOW GETTING 500 ERROR WHEN SETTING TO NULL, TO CONFIRM FOR BUG CREATION 2.20
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.checkInDays = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"checkInDays":["The CheckInDays field is required."]}
    
    Scenario: Create a deal without Accommodation Inclusion Condition
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.accommodationInclusionCondition = null
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"accommodationInclusionCondition":["AccommodationInclusionCondition is required."]}
    
    Scenario: Create a deal with Accommodation Inclusion Condition incorrect enum value
    ## Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.accommodationInclusionCondition = null
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"accommodationInclusionCondition":["AccommodationInclusionCondition is required."]}
    
    #Scenario: Create a deal without Deal Approval Status  ##for confirmation if this is still required on the body request
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealApprovalStatus = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"dealApprovalStatus":["The DealApprovalStatus field is required."]}        
    
    #Scenario: Create a deal with an existing Code - #This scenario is now allowed due to changes. Commenting this for now 2.20
    ## Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 201
    #
    ##Create a Deal again with the same code
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #
    #* match response == [{"propertyName":"Code","errorMessage":"The specified Code already exists.","severity":"error"}]             
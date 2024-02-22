#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCampaign = read('../dealCampaign/dealCampaign.json')
    * def dealCampaignMultiple = read('../dealCampaign/dealCampaignMultiple.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
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
    * def campaignCode =  'AUTO - ' + random_string(5)
    * def campaignCodeupdated =  'AUTOUPDATE - ' + random_string(7)

  Scenario: Create deal campaign
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = campaignCode
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method post
    Then status 200
    And match response contains {id: '#uuid'}   
    And print response.id
    * def campId = response.id
    ### Get all deal Campaign
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method get
    Then status 200
    ### Get individual campaign
    Given path 'api/deal-campaign/'+ campId +''
    When request dealCampaign
    When method get
    Then status 200
    ### update individual campaign
    * set dealCampaign.campaignCodeupdated = campaignCodeupdated
    Given path 'api/deal-campaign/'+ campId +''
    When request dealCampaign
    When method put
    Then status 200
    ### delete individual campaign
    * set dealCampaign.campaignCodeupdated = campaignCodeupdated
    Given path 'api/deal-campaign/'+ campId +''
    When request dealCampaign
    When method delete
    Then status 204

  ### negative validations
  Scenario: Create a deal campaign without campaign name
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "AUTO",
  "campaignName": null,
  "campaignDescription": "AUTO",
  "campaignContactPerson": "AUTO",
  "isActive": true,
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "79089c50-17b4-ee11-be9e-000d3ad01148",
  "checkInDays": {
    "monday": true,
    "tuesday": true,
    "wednesday": true,
    "thursday": true,
    "friday": true,
    "saturday": true,
    "sunday": true
  },
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignConditions": [
    {
      "conditionId": "8f26b4c0-9a67-462a-8bc9-662b2a90957e",
      "conditionValue": "string"
    }
  ],
  "campaignAvailability": {
    "bookingDateRange": {
      "startDate": "2024-04-25T05:28:01.515Z",
      "endDate": "2024-05-25T05:28:01.515Z"
    },
    "stayDateRange": {
      "startDate": "2024-06-25T05:28:01.515Z",
      "endDate": "2024-07-25T05:28:01.515Z"
    },
    "blackoutDateRanges": [
      {
        "startDate": "2024-07-26T05:28:01.515Z",
        "endDate": "2024-07-27T05:28:01.515Z"
      }
    ]
  },
  "campaignParticipants": [
    {
      "parkCode": "SADO"
    }
  ]
}
      """
    When method post
    Then status 400
    #* match response.errors == {"campaignName": ["The CampaignName field is required." ]  }

  Scenario: Create a deal campaign without Campaign Description
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "AUTO",
  "campaignName": "AUTO",
  "campaignDescription": null,
  "campaignContactPerson": "AUTO",
  "isActive": true,
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "79089c50-17b4-ee11-be9e-000d3ad01148",
  "checkInDays": {
    "monday": true,
    "tuesday": true,
    "wednesday": true,
    "thursday": true,
    "friday": true,
    "saturday": true,
    "sunday": true
  },
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignConditions": [
    {
      "conditionId": "8f26b4c0-9a67-462a-8bc9-662b2a90957e",
      "conditionValue": "string"
    }
  ],
  "campaignAvailability": {
    "bookingDateRange": {
      "startDate": "2024-04-25T05:28:01.515Z",
      "endDate": "2024-05-25T05:28:01.515Z"
    },
    "stayDateRange": {
      "startDate": "2024-06-25T05:28:01.515Z",
      "endDate": "2024-07-25T05:28:01.515Z"
    },
    "blackoutDateRanges": [
      {
        "startDate": "2024-07-26T05:28:01.515Z",
        "endDate": "2024-07-27T05:28:01.515Z"
      }
    ]
  },
  "campaignParticipants": [
    {
      "parkCode": "SADO"
    }
  ]
}
      """
    When method post
    Then status 400
    #* match response.errors == { "campaignDescription": [ "The CampaignDescription field is required." ]  }

  #Scenario: Create a deal campaign without Check In Days - WILL RECOMMENT ONCE BUG IS FIXED - https://discoveryparks.atlassian.net/browse/DL20-1322
    #Given path 'api/deal-campaign'
    #When request
      #"""
#{
  #"campaignCode": "AUTO",
  #"campaignName": "AUTO",
  #"campaignDescription": "AUTO",
  #"campaignContactPerson": "AUTO",
  #"isActive": true,
  #"promotionalContent": {
    #"image": "string",
    #"text": "string"
  #},
  #"discountStructureId": "79089c50-17b4-ee11-be9e-000d3ad01148",
  #"checkInDays": null,
  #"accommodationInclusionCondition": "all",
  #"hidden": true,
  #"promoCode": "string",
  #"campaignConditions": [
    #{
      #"conditionId": "8f26b4c0-9a67-462a-8bc9-662b2a90957e",
      #"conditionValue": "string"
    #}
  #],
  #"campaignAvailability": {
    #"bookingDateRange": {
      #"startDate": "2024-04-25T05:28:01.515Z",
      #"endDate": "2024-05-25T05:28:01.515Z"
    #},
    #"stayDateRange": {
      #"startDate": "2024-06-25T05:28:01.515Z",
      #"endDate": "2024-07-25T05:28:01.515Z"
    #},
    #"blackoutDateRanges": [
      #{
        #"startDate": "2024-07-26T05:28:01.515Z",
        #"endDate": "2024-07-27T05:28:01.515Z"
      #}
    #]
  #},
  #"campaignParticipants": [
    #{
      #"parkCode": "SADO"
    #}
  #]
#}
      #"""
    #When method post
    #Then status 400
    #* match response.errors == { "checkInDays": [ "The CheckInDays field is required." ]  }

  Scenario: Create a deal campaign without Accommodation Inclusion Condition
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "AUTO",
  "campaignName": "AUTO",
  "campaignDescription": "AUTO",
  "campaignContactPerson": "AUTO",
  "isActive": true,
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "79089c50-17b4-ee11-be9e-000d3ad01148",
  "checkInDays": {
    "monday": true,
    "tuesday": true,
    "wednesday": true,
    "thursday": true,
    "friday": true,
    "saturday": true,
    "sunday": true
  },
  "accommodationInclusionCondition": null,
  "hidden": true,
  "promoCode": "string",
  "campaignConditions": [
    {
      "conditionId": "8f26b4c0-9a67-462a-8bc9-662b2a90957e",
      "conditionValue": "string"
    }
  ],
  "campaignAvailability": {
    "bookingDateRange": {
      "startDate": "2024-04-25T05:28:01.515Z",
      "endDate": "2024-05-25T05:28:01.515Z"
    },
    "stayDateRange": {
      "startDate": "2024-06-25T05:28:01.515Z",
      "endDate": "2024-07-25T05:28:01.515Z"
    },
    "blackoutDateRanges": [
      {
        "startDate": "2024-07-26T05:28:01.515Z",
        "endDate": "2024-07-27T05:28:01.515Z"
      }
    ]
  },
  "campaignParticipants": [
    {
      "parkCode": "SADO"
    }
  ]
}
      """
    When method post
    Then status 400
    * match response.errors == { "accommodationInclusionCondition": [ "AccommodationInclusionCondition is required." ]  }

  Scenario: Create a deal campaign without Campaign Code
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignName": "AUTO",
  "campaignDescription": "AUTO",
  "campaignContactPerson": "AUTO",
  "isActive": true,
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "79089c50-17b4-ee11-be9e-000d3ad01148",
  "checkInDays": {
    "monday": true,
    "tuesday": true,
    "wednesday": true,
    "thursday": true,
    "friday": true,
    "saturday": true,
    "sunday": true
  },
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignConditions": [
    {
      "conditionId": "8f26b4c0-9a67-462a-8bc9-662b2a90957e",
      "conditionValue": "string"
    }
  ],
  "campaignAvailability": {
    "bookingDateRange": {
      "startDate": "2024-04-25T05:28:01.515Z",
      "endDate": "2024-05-25T05:28:01.515Z"
    },
    "stayDateRange": {
      "startDate": "2024-06-25T05:28:01.515Z",
      "endDate": "2024-07-25T05:28:01.515Z"
    },
    "blackoutDateRanges": [
      {
        "startDate": "2024-07-26T05:28:01.515Z",
        "endDate": "2024-07-27T05:28:01.515Z"
      }
    ]
  },
  "campaignParticipants": [
    {
      "parkCode": "SADO"
    }
  ]
}
      """
    When method post
    Then status 400
    #* match response.errors == { "campaignCode": ["The CampaignCode field is required."]  }
    
  #Scenario: Create deal campaign and multiple participant - COMMENTING THIS ONE AFFECTED WITH THE BUG https://discoveryparks.atlassian.net/browse/DL20-1234
    ### Create a new deal campaign 
    #* set dealCampaign.campaignCode = campaignCode
    #Given path 'api/deal-campaign'
    #When request dealCampaignMultiple
    #When method post
    #Then status 200
    #And match response contains {id: '#uuid'}   
    #And print response.id
    #* def campId = response.id
    ### Get all deal Campaign
    #Given path 'api/deal-campaign'
    #When request dealCampaign
    #When method get
    #Then status 200
    ### Get individual campaign
    #Given path 'api/deal-campaign/'+ campId +''
    #When request dealCampaign
    #When method get
    #Then status 200
    ### update individual campaign
    #* set dealCampaign.campaignCodeupdated = campaignCodeupdated
    #Given path 'api/deal-campaign/'+ campId +''
    #When request dealCampaign
    #When method put
    #Then status 200
    ### delete individual campaign
    #* set dealCampaign.campaignCodeupdated = campaignCodeupdated
    #Given path 'api/deal-campaign/'+ campId +''
    #When request dealCampaign
    #When method delete
    #Then status 204  
    
  Scenario: Create Deal Campaign and retrieve multiple status
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = campaignCode
    Given path 'api/deal-campaign'
    When request dealCampaignMultiple
    When method post
    Then status 200
    And match response contains {id: '#uuid'}   
    And print response.id
    * def campId = response.id
    ### Get all deal Campaign
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method get
    Then status 200
    ### Get individual campaign
    Given path 'api/deal-campaign/'+ campId +''
    When request dealCampaign
    When method get
    Then status 200
    * match response.campaignParticipants[0].status == 'invited'
    * match response.campaignParticipants[1].status == 'invited'
    
    ### delete individual campaign
    * set dealCampaign.campaignCodeupdated = campaignCodeupdated
    Given path 'api/deal-campaign/'+ campId +''
    When request dealCampaign
    When method delete
    Then status 204    	      
    
  Scenario: Get Deal Campaign and retrieve single status
    ### Get individual campaign
    Given path 'api/deal-campaign/'+ 'c9be8800-3dd1-ee11-85f7-002248975a78' +''
    When request dealCampaign
    When method get
    Then status 200
    * match response.campaignParticipants[0].status == 'optedIn'

  Scenario: Get Deal Campaign and retrieve single status for G'day parks
    ### Get individual campaign
    Given path 'api/deal-campaign/'+ '9a902f13-3fd1-ee11-85f7-002248975a78' +''
    When request dealCampaign
    When method get
    Then status 200
    * match response.campaignParticipants[0].status == 'invited'    
    
  Scenario: Create Deal Campaign with invalid Discount Structure
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = campaignCode
    * set dealCampaign.discountStructureId = "1735728d-6007-4d9b-acd6-92ced907c5cc"
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method post
    Then status 400
    
  Scenario: Create Deal Campaign without Discount Structure
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = campaignCode
    * set dealCampaign.discountStructureId = null
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method post
    Then status 400    
    
  Scenario: Create Deal Campaign without Campaign Name, Campaign Code, and Campaign Description
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = null
    * set dealCampaign.campaignName = null
    * set dealCampaign.campaignDescription = null
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method post
    Then status 400        
    	    

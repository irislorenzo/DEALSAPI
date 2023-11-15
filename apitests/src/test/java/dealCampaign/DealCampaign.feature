#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCampaign = read('../dealCampaign/dealCampaign.json')
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
    * def campaignCode =  random_string(5)
    * def campaignCodeupdated =  random_string(7)

  Scenario: Create deal campaign
    ### Create a new deal campaign 
    * set dealCampaign.campaignCode = campaignCode
    Given path 'api/deal-campaign'
    When request dealCampaign
    When method post
    Then status 200
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
  "campaignCode": "Without Condition1",
  "campaignName": "",
  "campaignDescription": "string",
  "campaignContactPerson": "string",
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignCondition": [
    {
        "conditionId" : "cbf03af5-4846-ee11-9937-000d3a6a33fb",
      "conditionValue": "string",
    }
  ],
  "checkInDays": [1,1,1,1,1,1,1],
  "campaignAvailability": {
    "bookingDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "stayDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "blackoutDateRanges": [
      [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
      ]
    ]
  }
}
      """
    When method post
    Then status 400
    * match response.errors == {"campaignName": ["The CampaignName field is required." ]  }

  Scenario: Create a deal campaign without Campaign Description
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "Without Condition",
  "campaignName": "string",
  "campaignDescription": "",
  "campaignContactPerson": "string",
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignCondition": [
    {
        "conditionId" : "cbf03af5-4846-ee11-9937-000d3a6a33fb",
      "conditionValue": "string",
    }
  ],
  "checkInDays": [1,1,1,1,1,1,1],
  "campaignAvailability": {
    "bookingDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "stayDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "blackoutDateRanges": [
      [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
      ]
    ]
  }
}
      """
    When method post
    Then status 400
    * match response.errors == { "campaignDescription": [ "The CampaignDescription field is required." ]  }

  Scenario: Create a deal campaign without Check In Days
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "Without Condition 3",
  "campaignName": "string",
  "campaignDescription": "string",
  "campaignContactPerson": "string",
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignCondition": [
    {
        "conditionId" : "cbf03af5-4846-ee11-9937-000d3a6a33fb",
      "conditionValue": "string"
    }
  ],
  "checkInDaysData": [],
  "campaignAvailability": {
    "bookingDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "stayDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "blackoutDateRanges": [
      [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
      ]
    ]
  }
}
      """
    When method post
    Then status 400
    * match response.errors == { "checkInDays": [ "The CheckInDays field is required." ]  }

  Scenario: Create a deal campaign without Accommodation Inclusion Condition
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "WITHOUTAIC",
  "campaignName": "string",
  "campaignDescription": "string",
  "campaignContactPerson": "string",
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "accommodationInclusionCondition": "",
  "hidden": true,
  "promoCode": "string",
  "campaignCondition": [
    {
        "conditionId" : "b073703f-b66b-ee11-9938-000d3ad19437",
      "conditionValue": "string",
    }
  ],
  "checkInDays": [1,1,1,1,1,1,1],
  "campaignAvailability": {
    "bookingDateRange": [
      "2023-10-17T01:09:56.929Z", "2023-10-19T01:09:56.929Z"
    ],
    "stayDateRange": [
      "2023-10-17T01:09:56.929Z", "2023-10-19T01:09:56.929Z"
    ],
    "blackoutDateRanges": [
      [
      "2023-10-29T01:09:56.929Z", "2023-10-30T01:09:56.929Z"
      ]
    ]
  }
}
      """
    When method post
    Then status 400
    * match response.errors == { "accommodationInclusionCondition": [ "The AccommodationInclusionCondition field is required." ]  }

  Scenario: Create a deal campaign without Campaign Code
    Given path 'api/deal-campaign'
    When request
      """
{
  "campaignCode": "",
  "campaignName": "string",
  "campaignDescription": "string",
  "campaignContactPerson": "string",
  "promotionalContent": {
    "image": "string",
    "text": "string"
  },
  "discountStructureId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "accommodationInclusionCondition": "all",
  "hidden": true,
  "promoCode": "string",
  "campaignCondition": [
    {
        "conditionId" : "cbf03af5-4846-ee11-9937-000d3a6a33fb",
      "conditionValue": "string",
    }
  ],
  "checkInDays": [1,1,1,1,1,1,1],
  "campaignAvailability": {
    "bookingDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "stayDateRange": [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
    ],
    "blackoutDateRanges": [
      [
      "2023-10-15T01:09:56.929Z", "2023-10-16T01:09:56.929Z"
      ]
    ]
  }
}
      """
    When method post
    Then status 400
    * match response.errors == { "campaignCode": ["The CampaignCode field is required."]  }

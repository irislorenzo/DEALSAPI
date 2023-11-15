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

  Scenario: Deal campaign participant e2e
  #Create participants
  Given path 'api/Deal-Campaign/dabc240c-d981-ee11-8925-00224898d513/participants'
    When request 
    """
    {
 "parkCode": "SADO",
 "status": 0
     }
    """
    When method post
    Then status 200
    * def id = response.campaignId
    
    
    #Get Participants
     Given path 'api/Deal-Campaign/dabc240c-d981-ee11-8925-00224898d513/participants/'+ campaignId +''
    When method get
    Then status 200
    
    #Update participants
    Given path 'api/Deal-Campaign/dabc240c-d981-ee11-8925-00224898d513/participants/'+ campaignId +''
    When request 
    """
    {
                "campaignId": "b35f50bb-4671-ee11-9938-000d3ad19437",
                "parkCode": "SADO",
                "status": 1
                
            }
    """
    When method put
    Then status 200
  
    
    # Delete participants
    Given path 'api/Deal-Campaign/dabc240c-d981-ee11-8925-00224898d513/participants/'+ campaignId +''
    When method delete
    Then status 204
   
  
    
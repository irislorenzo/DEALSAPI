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

  Scenario: Create a new condtion
    ### Create a condtion
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
    
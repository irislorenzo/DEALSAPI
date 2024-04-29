#Author: jeugenio
Feature: Deal Reader Role Validation

  Background: 
    * url dealsUrl
    * def CreateDeal = read('../deals/CreateDealV2.json')
    * def DealSchema = read('../deals/DealSchema.json')
    * def PutDeal = read('../deals/PutDeal.json')
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
    * def result = call read('classpath:deals/get-token-Reader-Deals.feature')
    * karate.configure('headers', { 'Authorization': result.token });

  Scenario: Create Deal as Reader Role
   # #Create a Deal
    * set CreateDeal.code = 'AUTO_Contributor_DEAL_E2E' 
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 403
    
  Scenario: Update Deal as Reader Role
    # Get Drafted status Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'drafted').id
    And print newId
  
    # #Update a Deal
    Given path 'api/v2/deals/'+ newId +''
    When request PutDeal
    When method put
    Then status 403     
    
		Scenario: Get all Deals as Reader Role
    ##Get all Deals
    Given path 'api/v2/deals/'
    When method get
    Then status 200
    
  	Scenario: Submit Deal as Reader Role    
    # Get Drafted status Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'drafted').id
    And print newId
    
    # Submit a Deal
    Given path 'api/deals/'+ newId + '/submit'
    When method POST
    Then status 403
    
 	 	Scenario: Reject Deal as Reader Role
    ## Get awaitingApprovalStatus Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'awaitingApproval').id
    And print newId
    
    ## Reject a Deal
    Given path 'api/deals/'+ newId + '/reject'
    #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When request 
    """
    {
    "reason": "DEALS_AUTOMATION - REJECT DEAL"
		}
		"""
    When method POST
    Then status 403
    
    Scenario: Approve Deal as Reader Role    
     #Get a Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'awaitingApproval').id
    And print newId
    
     #Approve a Deal
    Given path 'api/deals/'+ newId + '/approve'
     #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 403
    
    Scenario: Delete Deal as Reader Role
    
    #Get inactive Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealStatus == 'inactive').id
    And print newId
    
    # delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 403   
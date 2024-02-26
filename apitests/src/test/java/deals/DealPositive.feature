#Author: spalaniappan
Feature: Deal Entity validation

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

  Scenario: Deal E2E
     Create a Deal
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 201
    And print UUID
    And print Description
    * match response == {"message":"Deal created successfully."}
    
     #Get a Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.code == 'DEALS_AUTOMATION').id
    And print newId
    
     #Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ newId +''
    When method get
    Then status 200
    
     #Update a Deal
    Given path 'api/v2/deals/'+ newId +''
    When request PutDeal
    When method put
    Then status 200

     #delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204
    
		Scenario: Get all Deals    
     Get all Deals
    Given path 'api/v2/deals/'
    When method get
    Then status 200
    
  	Scenario: Submit and Approve Deal
     #Create a Deal
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 201
    And print Description
    * match response == {"message":"Deal created successfully."}
    
    # Get a Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.code == 'DEALS_AUTOMATION').id
    And print newId
    
     #Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ newId +''
    When method get
    Then status 200
    
    # Submit a Deal
    Given path 'api/deals/'+ newId + '/submit'
    When method POST
    Then status 204
    
    # Approve a Deal
    Given path 'api/deals/'+ newId + '/approve'
     #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 204

    # delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204    
    
 	 	Scenario: Submit and Reject Deal
    ## Create a Deal
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 201
    And print Description
    * match response == {"message":"Deal created successfully."}
    
    ## Get recently created Deal
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.code == 'DEALS_AUTOMATION').id
    And print newId
    
    ## Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ newId +''
    When method get
    Then status 200
    
    ## Submit a Deal
    Given path 'api/deals/'+ newId + '/submit'
    When method POST
    Then status 204
    
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
    Then status 204

    ## delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204     
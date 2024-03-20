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
    
    Scenario: Create a deal without a Deal Status
    #COMMENTED FOR NOW, BUG CREATED DL-1320 fix 3.6.24
    # Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.dealStatus = null
    Given path 'api/v2/deals'
    When request CreateDeal
    When method post
    Then status 400
    * match response.errors == {"dealStatus":["The DealStatus field is required."]}

    #Scenario: Create a deal without a Deal Type COMMENTED FOR NOW, SEE COMMENT ON BUG DL20-1320
    # Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealType = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"dealType":["The DealType field is required."]}

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
    
    Scenario: Create a deal without Check In Days 
    #COMMENTED FOR NOW GETTING 500 ERROR WHEN SETTING TO NULL, BUG ADDED DL-1320 - FIX 3.6.24
    # Create a Deal
    * set CreateDeal.dealId = UUID
    * set CreateDeal.code = code
    * set CreateDeal.description = Description
    * set CreateDeal.checkInDays = null
    Given path 'api/v2/deals'
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
    
    #Scenario: Create a deal without Deal Approval Status  -REMOVE FROM NOW, SEE COMMENT ON BUG added DL-1320
    # Create a Deal
    #* set CreateDeal.dealId = UUID
    #* set CreateDeal.code = code
    #* set CreateDeal.description = Description
    #* set CreateDeal.dealApprovalStatus = null
    #Given path 'api/v2/deals'
    #When request CreateDeal
    #When method post
    #Then status 400
    #* match response.errors == {"dealApprovalStatus":["The DealApprovalStatus field is required."]}        
    
  	Scenario: Submit an Approved Deal    
    ## Get all Deals
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'approved').id
    And print newId
    
    ## Submit a Deal
    Given path 'api/deals/'+ newId + '/submit'
    When method POST
    Then status 400
    * match response == ["Deal cannot be submitted from an approved state"]
    
 		Scenario: Submit a Rejected Deal    
    ## Get all Deals
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'rejected').id
    And print newId
    
    ## Submit a Deal
    Given path 'api/deals/'+ newId + '/submit'
    When method POST
    Then status 400
    * match response == ["Deal cannot be submitted from a rejected state"]   
    
 		Scenario: Reject an Approved Deal    
    ## Get all Deals
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'approved').id
    And print newId
    
    # Reject a Deal
    Given path 'api/deals/'+ newId + '/reject'
    # Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When request 
    """
    {
    "reason": "DEALS_AUTOMATION - REJECT DEAL"
		}
		"""
    When method POST
    Then status 400   
    * match response == ["Deal cannot be rejected when it is already in approved state"]
    
 		Scenario: Approved a Rejected Deal    
    ## Get all Deals
    Given path 'api/v2/deals'
    When method get
    Then status 200
    * def newId = response.find(x => x.dealApprovalStatus == 'rejected').id
    And print newId
    
    # Approved a Deal
    Given path 'api/deals/'+ newId + '/approve'
    # Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 400   
    * match response == ["Cannot approve a deal in rejected state"]    
    
  Scenario: Approve a Deal without Business Development Manager Role
     #Create a Deal
    * set CreateDeal.code = 'APPROVE_WO_BDM_ROLE'
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
    * def newId = response.find(x => x.code == 'APPROVE_WO_BDM_ROLE').id
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
    #Remove header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 400
    * match response == ["User does not have rights to approve deal from awaiting approval state"]

    # delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204    
    
  Scenario: Reject a Deal without Business Development Manager Role
    ## Create a Deal
    * set CreateDeal.code = "REJECT_WO_BDM_ROLE"
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
    * def newId = response.find(x => x.code == 'REJECT_WO_BDM_ROLE').id
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
    #No header Role = 'BusinessDevelopmentManager'
    When request 
    """
    {
    "reason": "DEALS_AUTOMATION - REJECT DEAL"
		}
		"""
    When method POST
    Then  status 400
    * match response == ["User does not have permission to reject deal"]

    ## delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204        
                
  	Scenario: Approve deal from Drafted State
     #Create a Deal
    * set CreateDeal.code = "APPROVE_FROM_DRAFT"
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
    * def newId = response.find(x => x.code == 'APPROVE_FROM_DRAFT').id
    And print newId
    
     #Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ newId +''
    When method get
    Then status 200
    
    # Approve a Deal
    Given path 'api/deals/'+ newId + '/approve'
    #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 400
    * match response == ["Deal cannot be approved from draft state. Deal has to be submitted first"]

    # delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204    
    
  	Scenario: Reject deal from Drafted State
    ## Create a Deal
    * set CreateDeal.code = "APPROVE_WO_BDM_ROLE"
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
    * def newId = response.find(x => x.code == 'APPROVE_WO_BDM_ROLE').id
    And print newId
    
    ## Get a Deal  with specific ID
    Given path 'api/v2/deals/'+ newId +''
    When method get
    Then status 200
    
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
    Then  status 400
    * match response == ["Deal cannot move from Draft to Reject state"]

    ## delete a Deal
    Given path 'api/deals/'+ newId +''
    When method delete
    Then status 204      
    
  	Scenario: Submit non-existing Deal    
    # Submit a Deal
    Given path 'api/deals/'+ 'c7dfb0b4-67a0-478d-8117-9a4c2d1bb2ca' + '/submit'
    When method POST
    Then status 400
    * match response == ["Deal does not exist"]      
    
  	Scenario: Approve non-existing Deal    
    # Approve a Deal
    Given path 'api/deals/'+ 'c7dfb0b4-67a0-478d-8117-9a4c2d1bb2ca' + '/approve'
     #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When method POST
    Then status 400
    * match response == ["Deal does not exist"]  
    
 	 	Scenario: Reject non-existing Deal   
    ## Reject a Deal
    Given path 'api/deals/'+ 'c7dfb0b4-67a0-478d-8117-9a4c2d1bb2ca' + '/reject'
    #Need BDM Role to approve/reject deal
    * header Role = 'BusinessDevelopmentManager'
    When request 
    """
    {
    "reason": "DEALS_AUTOMATION - REJECT DEAL"
		}
		"""
    When method POST
    Then status 400           
    * match response == ["Deal does not exist"]   
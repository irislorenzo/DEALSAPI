#Author: jeugenio 
Feature: Deal Template Entity validation Contributor Role

  Background: 
    * url dealsUrl
    * def CreateDealTemplate = read('../dealTemplate/CreateDealTemplate.json')
    * def DealTemplateSchema = read('../dealTemplate/DealTemplateSchema.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    * def result = call read('classpath:deals/get-token-Reader-Deals.feature')
 		* karate.configure('headers', { 'Authorization': result.token });

  Scenario: Deal template E2E
    # Create a Deal Template
    #* set CreateDealTemplate.ID = UUID
    Given path 'api/deal-template'
    When request CreateDealTemplate
    When method post
    Then status 403
    
    # Get all Deal Template
    Given path 'api/deal-template/'
    When method get
    Then status 200
    * def newId = response.find(x => x.status == 'active').id
    And print newId
    
    #Get a Deal Template  with specific ID
    Given path 'api/deal-template/' + newId +''
    When method get
    Then status 200

  #Negative Validations
  Scenario: Deal Template Send Invalid request without Name
    Given path 'api/deal-template'
    When request
      """
      {
      "status": "Active",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403

  Scenario: Deal Template Invalid request with no promotional content
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Standard",
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34",
      "discountStructureId": "f37df361-17b4-ee11-be9e-000d3ad01148",
      "brands": [
      "dhp", "gday"
      ],
      "conditions": []
      }
      """
    When method post
    Then status 403

  	
  Scenario: Deal Template Invalid request without Status
  #FIXED 3.6.24
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403


  Scenario: Invalid request without Deal Type
  #FIXED 3.6.24
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403

  Scenario: Invalid request using incorrect value for Status
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Test",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403

  Scenario: Invalid request using incorrect value for Deal Type
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Test",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403

  Scenario: Invalid request using incorrect value for Deal Type
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Test",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "37722ec5-f920-4ef8-a65c-d82a4b7ee54f",
      "discountStructureId": "fa6aba27-8f02-4e63-86f7-dd3ed2bfe3e5"
      }
      """
    When method post
    Then status 403

  Scenario: Invalid request without Discount structure
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Archived",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34"
      }
      """
    When method post
    Then status 403

  Scenario: Invalid request without a Brand
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34",
      "discountStructureId": "74370d02-4636-ee11-b8f0-002248971d34",
      "conditions": [
      {
        "conditionId": "b92e77d8-e734-ee11-b8f0-002248971d34",
        "conditionValue": "string"
      }
      ]
      }
      """
    When method post
    Then status 403

  Scenario: Create a Deal Template with multiple brands
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free 4",
      "status": "Active",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "a217d4fe-9138-ee11-b8f0-002248971d34",
      "discountStructureId": "ed3fb5b3-5936-ee11-b8f0-002248971d34",
      "brands": [
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "e751812c-9031-ee11-b8f0-002248971d34"
      ],
      "conditions": [
      {
      "conditionId": "b92e77d8-e734-ee11-b8f0-002248971d34",
      "conditionValue": "string"
      }
      ]
      }
      """
    When method post
    Then status 403

  Scenario: Create a deal template with multiple conditions
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free 1",
      "status": "Active",
      "dealType": "Standard",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34",
      "discountStructureId": "74370d02-4636-ee11-b8f0-002248971d34",
      "conditions": [
      {
      "conditionId": "d7068bfd-b035-ee11-b8f0-002248971d34",
      "conditionValue": "integer"
      },
      {
      "conditionId": "b92e77d8-e734-ee11-b8f0-002248971d34",
      "conditionValue": "string"
      }
      ]
      }
      """
    When method post
    Then status 403

  Scenario: Create a deal template without conditions
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free 2",
      "status": "Active",
      "dealType": "Campaign",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "c24d4457-e737-ee11-b8f0-002248971d34",
      "discountStructureId": "e3e2201e-4936-ee11-b8f0-002248971d34"
      }
      """
    When method post
    Then status 403

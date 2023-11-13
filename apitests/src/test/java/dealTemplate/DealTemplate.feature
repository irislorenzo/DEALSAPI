#Author: spalaniappan
Feature: Deal Template Entity validation

  Background: 
    * url dealsUrl
    * def CreateDealTemplate = read('../dealTemplate/CreateDealTemplate.json')
    * def DealTemplateSchema = read('../dealTemplate/DealTemplateSchema.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()

  Scenario: Deal template E2E
    # Create a Deal Template
    * set CreateDealTemplate.ID = UUID
    Given path 'api/deal-template'
    When request CreateDealTemplate
    When method post
    Then status 201
    * match response == {"message":"Deal Template created successfully."}
    # Get a Deal Template
    Given path 'api/deal-template/'
    When request CreateDealTemplate
    When method get
    Then status 200
    * match response[0] == DealTemplateSchema
    # Get a Deal Template with specific ID
    Given path 'api/deal-template/'+ UUID +''
    When method get
    Then status 200
    * match response == DealTemplateSchema
    # Update a Deal Template
    * set CreateDealTemplate.name = "Deal Template Automation-updated"
    Given path 'api/deal-template/'+ UUID +''
    When request CreateDealTemplate
    When method put
    Then status 200
    * match response == DealTemplateSchema
    # delete a Deal Template
    Given path 'api/deal-template/'+ UUID +''
    When method delete
    Then status 204

  ##Negative Validations
  Scenario: Send Invalid request without Name
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
    Then status 400
    * match response.errors == {  "name": [ "The Name field is required." ]    }

  Scenario: Invalid request with 121 chars in promotional content
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Standard",
      "promotionalContent": {
       "image": "string",
      "text": "6xQddBIGhvuvioHdgC4x6ghlK2jvmtixLNEmGlzu5WFQe6fQFiR7hzWDSwO9KEXlMzpGHI7744Vz1YtMT3L9MLgYh9Ug9SeOa6mSEMPyHu0qzLTJQ15PDICEOI6WjNpWIygrAbf3RhcBlk6G0wbzWdJWX4ocrewM6HKVPoxHqq8Cquhkz23qWk3P1BGYSoMigFm6yQdee"
      },
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34",
      "discountStructureId": "4d9fca01-f051-ee11-9938-000d3ad19d08",
      "brands": [{
              "brandId": "5b03e66d-d842-ee11-9937-000d3a6a33fb",
              "code": "DHP",
              "name": "Discovery Holiday Parks",
              "description": "Test brand"
          }
      
      ],
      "conditions": []
      }
      """
    When method post
    Then status 400
    * match response.errors == {  "promotionalContent.Text": [ "The field Text must be a string or array type with a maximum length of '120'." ]    }

  Scenario: Invalid request with no promotional content
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free",
      "status": "Active",
      "dealType": "Standard",
      "dealContentPolicyId": "29bf42b0-a535-ee11-b8f0-002248971d34",
      "discountStructureId": "74370d02-4636-ee11-b8f0-002248971d34",
      "brands": [
      {
              "brandId": "5b03e66d-d842-ee11-9937-000d3a6a33fb",
              "code": "DHP",
              "name": "Discovery Holiday Parks",
              "description": "Test brand"
          }
      ],
      "conditions": []
      }
      """
    When method post
    Then status 400
    * match response.errors == {  "promotionalContent": [ "The PromotionalContent field is required." ]    }

  Scenario: Invalid request without Status
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
    Then status 400
    * match response.errors == {  "status": [ "The Status field is required." ]    }

  Scenario: Invalid request without Deal Type
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
    Then status 400
    * match response.errors == {  "dealType": [ "The DealType field is required." ]    }

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
    Then status 400

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
    Then status 400

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
    Then status 400

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
    Then status 400

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
    Then status 400

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
    Then status 400

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
    Then status 400

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
    Then status 400

  Scenario: Create a deal template using Deal Content Policy that has different Deal Type from the Deal Template
    Given path 'api/deal-template'
    When request
      """
      {
      "name": "Second friday of the month for free 4",
      "status": "Active",
      "dealType": "Campaign",
      "promotionalContent": {
      "image": "https://test.photos/200",
      "text": "test"
      },
      "dealContentPolicyId": "b27caec4-a835-ee11-b8f0-002248971d34",
      "discountStructureId": "ed3fb5b3-5936-ee11-b8f0-002248971d34",
      "conditions": [
      {
      "conditionId": "b92e77d8-e734-ee11-b8f0-002248971d34",
      "conditionValue": "string"
      }
      ]
      }
      """
    When method post
    Then status 400

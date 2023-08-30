#Author: spalaniappan
Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealContentPolicy = read('../dealContentPolicy/DealContentPolicy.json')

  Scenario: Create a Content policy
    Given path 'api/dealcontentpolicy'
    When request
      """
      {
          "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
          "name": "POLICYAUTOMATION",
          "description": "POLICYAUTOMATION",
          "dealType": "standard",
          "policyItems": [
              {
                  "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
                  "label": "POLICYAUTOMATION-1",
                  "value": "fixed"
              },
              {
                  "id": "2c3675cd-c544-4573-9a85-cdbb7c31b449",
                  "label": "POLICYAUTOMATION2",
                  "value": "fixed"
              }
          ]
      }
      """
    When method post
    Then status 201
    * match response == {"message":"Deal Content Policy created successfully."}

  #### Get Content policy with the Content policy ID
    Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When method get
    Then status 200
    * match response == DealContentPolicy

  Scenario: Get all the available Content policy
    Given path 'api/dealcontentpolicy'
    When method get
    Then status 200
    * match response[0] == DealContentPolicy

  Scenario: Update Content policy using Content policy ID
    Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When request
      """
      {
          "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
          "name": "POLICYAUTOMATIONUPDATED",
          "description": "POLICYAUTOMATIONUPDATED",
          "dealType": "standard",
          "policyItems": [
              {
                  "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
                  "label": "POLICYAUTOMATION-1",
                  "value": "fixed"
              },
              {
                  "id": "2c3675cd-c544-4573-9a85-cdbb7c31b449",
                  "label": "POLICYAUTOMATION2",
                  "value": "fixed"
              }
          ]
      }
      """
    When method put
    Then status 200

  Scenario: Delete Content policy using Content policy ID
    Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When method delete
    Then status 204

  Scenario: Create Invalid Content policy request without name
    Given path 'api/dealcontentpolicy'
    When request
      """
      {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa8",
      "description": "Test policy",
      "dealType": "standard",
      "policyItems": [
      {
        "id": "3fa85f64-5717-4562-b3fc-2c963f66afa8",
        "label": "string",
        "value": "fixed"
      }
      ]
      }
      """
    When method post
    Then status 400
    * match response.errors == {"name":["The Name field is required."]}

  Scenario: Create Invalid Content policy request without Deal Type
    Given path 'api/dealcontentpolicy'
    When request
      """
      {
      "id": "1e492045-eb21-44bb-95fa-3bf1f66e3e5d",
      "name": "Po",
      "description": "Test policy",
      "policyItems": [
      {
        "id": "1e492045-eb21-44bb-95fa-3bf1f66e3e5d",
        "label": "string",
        "value": "fixed"
      }
      ]
      }
      """
    When method post
    Then status 400
    * match response.errors == {"dealType": ["Required property 'dealType' not found in JSON. Path '', line 1, position 180."]}

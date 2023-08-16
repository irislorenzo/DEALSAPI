#Author: spalaniappan


Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealContentPolicy = read('../DealContentPolicy/DealContentPolicy.json')
    
  
  
  Scenario: Create a Content policy
  ### Create a condtion
    Given path 'api/dealcontentpolicy'
    When request
    """
   {
        "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
        "name": "POLICY111",
        "description": "POLICY111",
        "dealType": "standard",
        "policyItems": [
            {
                "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
                "label": "POLICY1-ITEM11",
                "value": "fixed"
            },
            {
                "id": "2c3675cd-c544-4573-9a85-cdbb7c31b449",
                "label": "POLICY1-ITEM12",
                "value": "fixed"
            }
        ]
    }
    """
    When method post
    Then status 201
    * match response == {"message":"Deal Content Policy created successfully."}
    
    
   Scenario: Get condition with the condition ID
    Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When method get
    Then status 200
    * match response == DealContentPolicy
    
   Scenario: Get all the available conditons
    Given path 'api/dealcontentpolicy'
    When method get
    Then status 200
    * match response[0] == DealContentPolicy
    
    Scenario: Update condition using condition ID
     Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When request
    """
   {
        "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
        "name": "POLICY111",
        "description": "POLICY111",
        "dealType": "standard",
        "policyItems": [
            {
                "id": "2c3675cd-c544-4573-9a85-cdbb7c31b448",
                "label": "POLICY1-ITEM11",
                "value": "fixed"
            },
            {
                "id": "2c3675cd-c544-4573-9a85-cdbb7c31b449",
                "label": "POLICY1-ITEM13",
                "value": "fixed"
            }
        ]
    }
    """
    When method put
    Then status 200
    
    
    Scenario: Delete condition using condition ID
    Given path 'api/dealcontentpolicy/2c3675cd-c544-4573-9a85-cdbb7c31b448'
    When method delete
    Then status 204
    
    
  
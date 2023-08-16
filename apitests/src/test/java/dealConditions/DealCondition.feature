#Author: spalaniappan

@b2c
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCondition = read('../dealConditions/dealcondition.json')
    
  
  
  Scenario: Create a new condtion
  ### Create a condtion
    Given path 'api/Condition'
    When request
    """
    {
  "code": "maxstayDays",
  "conditionId": "9944d786-d114-4b71-8c46-dadb41211c33",
  "description": "Maximum stay in days",
  "conditionRuleId": "9944d786-d114-4b71-8c46-dadb41211c33",
  "conditionValueType": "Integer"
    }
    """
    When method post
    Then status 201
    * match response == {"message":"Condition created successfully."}
    
    
   Scenario: Get condition with the condition ID
    Given path 'api/Condition/9944d786-d114-4b71-8c46-dadb41211c33'
    When method get
    Then status 200
    * match response == dealCondition
    
   Scenario: Get all the available conditons
    Given path 'api/Condition'
    When method get
    Then status 200
    * match response[0] == dealCondition
    
    Scenario: Update condition using condition ID
     Given path 'api/Condition/9944d786-d114-4b71-8c46-dadb41211c33'
    When request
    """
    {
  "code": "maxstayDays",
  "conditionId": "9944d786-d114-4b71-8c46-dadb41211c33",
  "description": "Maximum stay in days- updated",
  "conditionRuleId": "9944d786-d114-4b71-8c46-dadb41211c33",
  "conditionValueType": "Integer"
    }
    """
    When method put
    Then status 200
    * match response == dealCondition
    
    
    Scenario: Delete condition using condition ID
    Given path 'api/Condition/9944d786-d114-4b71-8c46-dadb41211c33'
    When method delete
    Then status 204
    
    
  
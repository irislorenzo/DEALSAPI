#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCondition = read('../dealConditions/dealcondition.json')
    * def dealConditionCreate = read('../dealConditions/dealConditionCreate.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()

  Scenario: Create a new condtion
    ### Create a condtion
    * set dealConditionCreate.conditionId = UUID
    Given path 'api/Condition'
    When request dealConditionCreate
    When method post
    Then status 201
    * match response == {"message":"Condition created successfully."}

  #### Get condition with the condition ID
    Given path 'api/Condition/'+ UUID +''
    When method get
    Then status 200
    * match response == dealCondition

  ### Get all the available conditons
    Given path 'api/Condition'
    When method get
    Then status 200
    * match response[0] == dealCondition

 ### Update condition using condition ID
 * set dealConditionCreate.code = "maxstayDaysAutomation-Updated"
    Given path 'api/Condition/'+ UUID +''
    When request dealConditionCreate
    When method put
    Then status 200
    * match response == dealCondition

  ## Delete condition using condition ID
    Given path 'api/Condition/'+ UUID +''
    When method delete
    Then status 204

  ###Negative Validation
  Scenario: Send Invalid condition request without code
    Given path 'api/Condition'
    When request
      """
      {
      "conditionId": "4ec8c352-9c93-435d-8040-9d2645196f77",
      "description": "Maximum stay in days",
      "conditionRuleId": "4ec8c352-9c93-435d-8040-9d2645196f75",
      "conditionValueType": "Integer"
      }
      """
    When method post
    Then status 400
    * match response.errors == {"code": [   "The Code field is required." ]}

  Scenario: Send Invalid condition request without description
    Given path 'api/Condition'
    When request
      """
      {
      "code": "maxStayDays",
      "conditionId": "4ec8c352-9c93-435d-8040-9d2645196f75",
      "conditionRuleId": "4ec8c352-9c93-435d-8040-9d2645196f73",
      "conditionValueType": "Integer"
      }
      """
    When method post
    Then status 400
    * match response.errors ==  { "description": ["The Description field is required."]  }

  Scenario: Send Invalid condition without conditionValueType
    Given path 'api/Condition'
    When request
      """
      {
      "code": "maxStayDays",
      "conditionId": "4ec8c352-9c93-435d-8040-9d2645196f76",
      "description": "Maximum stay in days",
      "conditionRuleId": "4ec8c352-9c93-435d-8040-9d2645196f73"
      }
      """
    When method post
    Then status 400
    * match response.errors ==  { "conditionValueType": [ "The ConditionValueType field is required." ]}

  Scenario: Send Invalid condition with same code and description
    Given path 'api/Condition'
    When request
      """
      {
      "code": "maxstayDays",
      "conditionId": "a5695ccb-c93c-ee11-b8f0-002248971d34",
      "description": "Maximum stay in days",
      "conditionRuleId": "9944d786-d114-4b71-8c46-dadb41211c33",
      "conditionValueType": "Integer"
      }
      """
    When method post
    Then status 409
    * string temp = response
    * match temp contains 'A condition with the same Code or Description already exists.'

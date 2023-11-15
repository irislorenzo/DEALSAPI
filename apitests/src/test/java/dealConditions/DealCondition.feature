#Author: spalaniappan
Feature: Deal Condition Entity validation

  Background: 
    * url dealsUrl
    * def dealCondition = read('../dealConditions/dealcondition.json')
    * def dealConditionCreate = read('../dealConditions/dealConditionCreate.json')
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
 * def code =  random_string(5)
 * def Description =  random_string(7)

  Scenario: Create a new condtion
    ### Create a condtion
  
 
    
     ### Get all the available conditons
    Given path 'api/Conditions'
    When method get
    Then status 200
    * match response[0] == dealCondition
    * def UUIDres = response[0].id

  #### Get condition with the condition ID
    Given path 'api/Conditions/'+ UUIDres +''
    When method get
    Then status 200
    * match response == dealCondition


  ## Delete condition using condition ID
    Given path 'api/Conditions/'+ UUIDres +''
    When method delete
    Then status 204

   Given path 'api/Conditions'
    When request dealConditionCreate
    When method post
    Then status 201
    * match response == {"message":"Condition created successfully."}
    
  ###Negative Validation
  Scenario: Send Invalid condition request without code
    Given path 'api/Conditions'
    When request
      """
      {
      "description":"Advance booking days- Automation",
      "conditionRuleId":"9944d786-d114-4b71-8c46-dadb41211c11",
      "conditionValueType":"Integer"}
      """
    When method post
    Then status 400
    * match response.errors == {"code": [   "The Code field is required." ]}

  Scenario: Send Invalid condition request without description
    Given path 'api/Conditions'
    When request
      """
      {
        "code": "minimumNightStay",
        "conditionRuleId": "4ec8c352-9c93-435d-8040-9d2645196f75",
        "conditionValueType": "integer"
        
    }
      """
    When method post
    Then status 400
    * match response.errors ==  { "description": ["The Description field is required."]  }

  Scenario: Send Invalid condition without conditionValueType
    Given path 'api/Conditions'
    When request
      """
      {
        "code": "minimumNightStay",
        "description": "Maximum stay in days",
        "conditionRuleId": "4ec8c352-9c93-435d-8040-9d2645196f75",
        
    }
      """
    When method post
    Then status 400
    * match response.errors ==  { "conditionValueType": [ "The ConditionValueType field is required." ]}

  Scenario: Send Invalid condition with same code and description
    Given path 'api/Conditions'
    When request
      """
      {
        "code": "maximumNightStay",
        "description": "Maximum Night Stay",
        "conditionValueType": "integer",
        "id": "f38402b3-025d-42ec-8208-86aba1ae3b86"
    }
      """
    When method post
    Then status 400
    * string temp = response
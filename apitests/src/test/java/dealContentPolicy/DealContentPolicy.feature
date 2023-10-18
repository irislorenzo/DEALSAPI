#Author: spalaniappan
Feature: Deal content policy validation

  Background: 
    * url dealsUrl
    * def DealContentPolicy = read('../dealContentPolicy/DealContentPolicy.json')
    * def DealContentPolicyCreate = read('../dealContentPolicy/dealContentCreate.json')
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    * def UUID1 = uuid()
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
  * def Name =  random_string(7)
    

  Scenario: Create a Content policy
  * set DealContentPolicyCreate.id = UUID
  * set DealContentPolicyCreate.code = code
  * set DealContentPolicyCreate.description = Description
   * set DealContentPolicyCreate.name = Name
  * set DealContentPolicyCreate.policyItems[0].id = UUID1
  
    Given path 'api/deal-content-policy'
    When request DealContentPolicyCreate
    When method post
    Then status 201
    * match response == {"message":"Deal Content Policy created successfully."}

  #### Get Content policy with the Content policy ID
    Given path 'api/deal-content-policy/'+ UUID +''
    When method get
    Then status 200
    * match response == DealContentPolicy

  ###Get all the available Content policy
    Given path 'api/deal-content-policy'
    When method get
    Then status 200

  ####Update Content policy using Content policy ID
   * set DealContentPolicyCreate.name = "POLICYAUTOMATION-UPDATED"
   * set DealContentPolicyCreate.description = "POLICYAUTOMATION-UPDATED-DESC"
   
    Given path 'api/deal-content-policy/'+ UUID +''
    When request DealContentPolicyCreate
    When method put
    Then status 200

  ### Delete Content policy using Content policy ID
    Given path 'api/deal-content-policy/'+ UUID +''
    When method delete
    Then status 204

  Scenario: Create Invalid Content policy request without name
    Given path 'api/deal-content-policy'
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
    Given path 'api/deal-content-policy'
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

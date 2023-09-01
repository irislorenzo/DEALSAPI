#Author: spalaniappan
Feature: Deal Template Entity validation

  Background: 
    * url dealsUrl
    * def CreateDealTemplate = read('../dealTemplate/CreateDealTemplate.json') 
     * def DealTemplateSchema = read('../dealTemplate/DealTemplateSchema.json') 
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * def UUID = uuid()
    

  Scenario: Create a new Deal template
    ### Create a Deal Template
    * set CreateDealTemplate.ID = UUID
    Given path 'api/dealTemplate'
    When request CreateDealTemplate
    When method post
    Then status 201
    * match response == {"message":"Deal Template created successfully."}
    
    ### Get a Deal Template
    Given path 'api/dealTemplate/'
    When request CreateDealTemplate
    When method get
    Then status 200
    
    


  
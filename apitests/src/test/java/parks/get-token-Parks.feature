#author: gmassey
#Get a token

Feature: Get a Token

Background:
  * url authUrl
	# refer to karate-config.js
	# * def token = token

Scenario: Get a token
  Given url authUrl
  And form field grant_type = 'client_credentials'
  And form field client_id = 'c5f353de-4d5a-4633-a19a-2c751f1574da'
  And form field client_secret = '8XQ8Q~uFAIv2MkyvQ_cc6ZvPIWoOcSDtGVLgxbta'
  And form field scope = 'b3d9a293-0921-4679-b28d-c784c873d7ff/.default'
  When method post
  Then status 200
  * def token = 'Bearer ' + response.access_token
  * print 'token is: ', token
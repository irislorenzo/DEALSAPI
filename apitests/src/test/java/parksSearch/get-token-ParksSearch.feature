#author: gmassey
#Get a token

Feature: Get a Token

Background:
  * url authUrl
	# refer to karate-config.js
	# * def token = token

Scenario: Get a token Parks Search
  Given url authUrl
  And form field grant_type = 'client_credentials'
  And form field client_id = 'c5f353de-4d5a-4633-a19a-2c751f1574da'
  And form field client_secret = '8XQ8Q~uFAIv2MkyvQ_cc6ZvPIWoOcSDtGVLgxbta'
  And form field scope = 'bead3fc8-af78-4277-9f47-2abc2d7da71f/.default'
  When method post
  Then status 200
  * def token = 'Bearer ' + response.access_token
  * print 'token is: ', token
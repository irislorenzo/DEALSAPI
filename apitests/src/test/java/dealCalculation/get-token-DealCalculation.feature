#author: jeugenio
#Get a token

Feature: Get a Token

Background:
  * url authUrl
	# refer to karate-config.js
	# * def token = token

Scenario: Get a token Deal Calculation
  Given url authUrl
  And form field grant_type = 'client_credentials'
  And form field client_id = '0af52704-29ba-43e0-ac1a-930a79b80738'
  And form field client_secret = 'cHI8Q~8_3v4EtVu-CCMenrgf5BxG7PnGSi~x-cp0'
  And form field scope = 'cc408000-5f6b-428d-b835-9a15e39b1cb5/.default'
  When method post
  Then status 200
  * def token = 'Bearer ' + response.access_token
  * print 'token is: ', token
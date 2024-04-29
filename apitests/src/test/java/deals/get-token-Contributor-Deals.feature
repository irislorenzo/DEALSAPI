#author: jeugenio
#Get a token

Feature: Get a Token

Background:
  * url authUrl
	# refer to karate-config.js
	# * def token = token

Scenario: Get a token Contributor Role
  Given url authUrl
  And form field grant_type = 'client_credentials'
  And form field client_id = '774b31d8-8589-435e-94da-fc457c974b9b'
  And form field client_secret = 'M.R8Q~HSoq7quBLOHSVR_UJeUWri~UIW0tl~haU1'
  And form field scope = 'aca9b1e1-2f23-4e09-a2b0-b10ae7b6034b/.default'
  When method post
  Then status 200
  * def token = 'Bearer ' + response.access_token
  * print 'token is: ', token
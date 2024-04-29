#author: jeugenio
#Get a token

Feature: Get a Token

Background:
  * url authUrl
	# refer to karate-config.js
	# * def token = token

Scenario: Get a token Admin Role
  Given url authUrl
  And form field grant_type = 'client_credentials'
  And form field client_id = '447f7d26-cb0e-4607-956d-8ec471cc08a8'
  And form field client_secret = 'x5s8Q~VQr3Y-k_rpRqwSahuIt7REcc3AE2l_icI4'
  And form field scope = 'aca9b1e1-2f23-4e09-a2b0-b10ae7b6034b/.default'
  When method post
  Then status 200
  * def token = 'Bearer ' + response.access_token
  * print 'token is: ', token
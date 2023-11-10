function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'test';
  }
  var config = {
    env: env,
    memberUrl: 'http://dev-int-dhp-api-membership.azurewebsites.net/',
    authUrl: 'https://login.microsoftonline.com/1400c903-3a54-41dd-a597-241ce11262da/oauth2/v2.0/token',
    client_id: 'b7d4b085-65dd-4d9d-a807-9ed8a713f55e',
    client_secret: '7pm8Q~DSSaQulIANA1id~CACaa3xLq7-mUOWMcFN',
    scope: 'aca9b1e1-2f23-4e09-a2b0-b10ae7b6034b/.default',
    resource: 'https://discoveryparks.com.au/dev-int-api-v1',
    customerWebCdn: 'https://proddupe-strategicweb-cdn.azureedge.net',
    crmWebUrl: 'https://discoveryparksdev.crm6.dynamics.com/api/data/v8.2',
    crm_AuthUrl: 'https://login.microsoftonline.com/1400c903-3a54-41dd-a597-241ce11262da/oauth2/token',
    crm_ClientId: '29e2dad5-205a-4780-adff-4d7e7e219f97',
    crm_ClientSecret: 'ddd662e2-b64a-4c56-aa6e-acfe8797cdde',
    crm_Resource: 'https://discoveryparksdev.crm6.dynamics.com/',
    appUrl: 'https://dev-appintegrations-webapp.azurewebsites.net',
    b2cUrl: 'https://dev-authb2c-dhp-api-as.azurewebsites.net/',
    commsUrl: 'https://dev-communications-v2-dhp-api-as.azurewebsites.net/',
    subsUrl: 'https://dev-subscribers-as.azurewebsites.net',
    dealsUrl: 'https://dev-deals-v2-as.azurewebsites.net/',
    parksUrl: 'https://dev-parks-as.azurewebsites.net/'
  }
  if (env == 'dev') {
    
  } else if (env == 'test') {
    config.memberUrl = 'http://test-int-dhp-api-membership.azurewebsites.net/';
    config.customerWebCdn = 'https://proddupe-strategicweb-cdn.azureedge.net';
    config.authUrl = 'https://login.microsoftonline.com/1400c903-3a54-41dd-a597-241ce11262da/oauth2/v2.0/token',
    config.client_id = 'b7d4b085-65dd-4d9d-a807-9ed8a713f55e',
    config.client_secret = '7pm8Q~DSSaQulIANA1id~CACaa3xLq7-mUOWMcFN',
    config.scope = 'aca9b1e1-2f23-4e09-a2b0-b10ae7b6034b/.default',
    config.resource = 'https://discoveryparks.com.au/test-int-api-v1';
    config.crmWebUrl= 'https://discoveryparkstest.crm6.dynamics.com/api/data/v8.2';
    config.crm_ClientId = 'a50d2e6e-1e6f-4794-b2cc-19d2e9e74d2a';
    config.crm_ClientSecret = '2a477537-40a0-481f-ba4e-27b88440429b';
    config.crm_Resource = 'https://discoveryparkstest.crm6.dynamics.com/';
    config.appUrl = 'https://test-appintegrations-webapp.azurewebsites.net';
    config.b2cUrl = 'https://test-authb2c-dhp-api-as.azurewebsites.net';
    config.commsUrl = 'https://test-communications-v2-dhp-api-as.azurewebsites.net/';
    config.subsUrl = 'https://test-subscribers-as.azurewebsites.net';
    config.dealsUrl = 'https://test-deals-v2-as.azurewebsites.net/';
    config.parksUrl = 'https://test-parks-as.azurewebsites.net/';
    config.dealCalcUrl = 'https://test-deals-v2-calc-as.azurewebsites.net/';
    config.dynamicOfferUrl = 'https://test-offers-as.azurewebsites.net/api/offers';
  } else if(env == 'memberv2'){
	    config.memberUrl = 'https://test-int-dhp-api-membership-net6.azurewebsites.net/';
	    config.customerWebCdn = 'https://proddupe-strategicweb-cdn.azureedge.net';
	    config.client_id = '3d943fca-2431-4a91-94c9-94e6d633b789';
	    config.client_secret = '=G)nDvo#+}9IJmF^9x{bH';
	    config.resource = 'https://discoveryparks.com.au/test-int-api-v1';
	    config.crmWebUrl= 'https://discoveryparkstest.crm6.dynamics.com/api/data/v8.2';
	    config.crm_ClientId = 'a50d2e6e-1e6f-4794-b2cc-19d2e9e74d2a';
	    config.crm_ClientSecret = '2a477537-40a0-481f-ba4e-27b88440429b';
    	config.crm_Resource = 'https://discoveryparkstest.crm6.dynamics.com/';
    	config.appUrl = 'https://test-appintegrations-webapp.azurewebsites.net/index.html';
  } else if(env == 'prod'){
	    config.memberUrl = 'https://prod-int-dhp-api-membership-staging.azurewebsites.net/';
	    config.client_id = '6f68ae69-ab4a-4b49-9408-9bc48861b27d';
	    config.client_secret = 'FxVjLVtOfrXgzfWEa1vcxP8+CKblEZJyI9j10EFum28=';
	    config.resource = 'https://discoveryparks.com.au/prod-int-api-v1';
}


  // we don't have a mocked environment but it's here in case we want one
  if(env !== 'mock') {
    // this will get a token once and use it for all tests
    var result = karate.callSingle('classpath:signin/get-token-post.feature', config)
    // this sets the header for all api calls
    karate.configure('headers', { 'Authorization': result.token });
    config.token = result.token
  }
  return config;
}
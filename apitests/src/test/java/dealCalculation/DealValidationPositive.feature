#Author: jeugenio
Feature: Deal Validation Positive

  Background: 
    * url dealCalcUrl
    * def CreateDealValidation = read('../dealCalculation/CreateDealValidation.json')
 
    Scenario: Verify 15% Off Discount
    ## Get Deal Validation
    
    Given path 'api/accommodations/calculate-deals'
    When request CreateDealValidation
    When method post
    Then status 200     
    * match response.accommodationDeals[0].deals[*] contains { "dealCode": "SPRING101749", "dealDescription": "5% Off - Spring Season QG","promotionalContentText": "5% Off on Spring Season","promotionalContentImageUrl": null,"isDealApplied": false,"message": "Booking Dates are outside the Deal Stay date range: 9/1/2023 12:00:00 AM +00:00 → 11/30/2023 12:00:00 AM +00:00","totalPrice": 0,"pricing": [],"stayDateRange": [  "2023-09-01T00:00:00+00:00","2023-11-30T00:00:00+00:00"]}
    * match response.accommodationDeals[0].deals[*] contains {"dealCode":"PC15Off749","dealDescription":"15% Off - Promo Code QG","promotionalContentText":null,"promotionalContentImageUrl":null,"isDealApplied":true,"message":"","totalPrice":1140,"pricing":[{"date":"2024-02-05T00:00:00+00:00","baseRateAmountForTwoAdults":235,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal applied on 2/5/2024 12:00:00 AM"},{"date":"2024-02-06T00:00:00+00:00","baseRateAmountForTwoAdults":235,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal applied on 2/6/2024 12:00:00 AM"},{"date":"2024-02-07T00:00:00+00:00","baseRateAmountForTwoAdults":235,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal applied on 2/7/2024 12:00:00 AM"},{"date":"2024-02-08T00:00:00+00:00","baseRateAmountForTwoAdults":235,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal applied on 2/8/2024 12:00:00 AM"}],"stayDateRange":["2023-01-02T00:00:00+00:00","2025-12-31T00:00:00+00:00"]}
    * match response.accommodationDeals[0].deals[*] contains {"dealCode":"20OFFQG749","dealDescription":"20% Off QG","promotionalContentText":null,"promotionalContentImageUrl":null,"isDealApplied":true,"message":"","totalPrice":960,"pricing":[{"date":"2024-02-05T00:00:00+00:00","baseRateAmountForTwoAdults":200,"additionalAdultAmount":12,"childAmount":8,"petAmount":4,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":40,"message":"Deal applied on 2/5/2024 12:00:00 AM"},{"date":"2024-02-06T00:00:00+00:00","baseRateAmountForTwoAdults":200,"additionalAdultAmount":12,"childAmount":8,"petAmount":4,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":40,"message":"Deal applied on 2/6/2024 12:00:00 AM"},{"date":"2024-02-07T00:00:00+00:00","baseRateAmountForTwoAdults":200,"additionalAdultAmount":12,"childAmount":8,"petAmount":4,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":40,"message":"Deal applied on 2/7/2024 12:00:00 AM"},{"date":"2024-02-08T00:00:00+00:00","baseRateAmountForTwoAdults":200,"additionalAdultAmount":12,"childAmount":8,"petAmount":4,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":40,"message":"Deal applied on 2/8/2024 12:00:00 AM"}],"stayDateRange":["2023-01-02T00:00:00+00:00","2025-12-31T00:00:00+00:00"]}
    * match response.accommodationDeals[0].deals[*] contains {"dealCode":"KSF749","dealDescription":"Kids Stay Free QG","promotionalContentText":null,"promotionalContentImageUrl":null,"isDealApplied":true,"message":"","totalPrice":1000,"pricing":[{"date":"2024-02-05T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":true,"additionalChargeAmount":0,"message":"Deal applied on 2/5/2024 12:00:00 AM, additional charge on booking waivered for 0 Adults, 5 Children & 0 Pets."},{"date":"2024-02-06T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":true,"additionalChargeAmount":0,"message":"Deal applied on 2/6/2024 12:00:00 AM, additional charge on booking waivered for 0 Adults, 5 Children & 0 Pets."},{"date":"2024-02-07T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":true,"additionalChargeAmount":0,"message":"Deal applied on 2/7/2024 12:00:00 AM, additional charge on booking waivered for 0 Adults, 5 Children & 0 Pets."},{"date":"2024-02-08T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":true,"additionalChargeAmount":0,"message":"Deal applied on 2/8/2024 12:00:00 AM, additional charge on booking waivered for 0 Adults, 5 Children & 0 Pets."}],"stayDateRange":["2023-01-02T00:00:00+00:00","2025-12-31T00:00:00+00:00"]}
    * match response.accommodationDeals[0].deals[*] contains {"dealCode":"S3S30MID749","dealDescription":"Stay 3, Save 30% Midweek QG","promotionalContentText":null,"promotionalContentImageUrl":null,"isDealApplied":true,"message":"","totalPrice":840,"pricing":[{"date":"2024-02-05T00:00:00+00:00","baseRateAmountForTwoAdults":175,"additionalAdultAmount":10.5,"childAmount":7,"petAmount":3.5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":35,"message":"Deal applied on 2/5/2024 12:00:00 AM"},{"date":"2024-02-06T00:00:00+00:00","baseRateAmountForTwoAdults":175,"additionalAdultAmount":10.5,"childAmount":7,"petAmount":3.5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":35,"message":"Deal applied on 2/6/2024 12:00:00 AM"},{"date":"2024-02-07T00:00:00+00:00","baseRateAmountForTwoAdults":175,"additionalAdultAmount":10.5,"childAmount":7,"petAmount":3.5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":35,"message":"Deal applied on 2/7/2024 12:00:00 AM"},{"date":"2024-02-08T00:00:00+00:00","baseRateAmountForTwoAdults":175,"additionalAdultAmount":10.5,"childAmount":7,"petAmount":3.5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":35,"message":"Deal applied on 2/8/2024 12:00:00 AM"}],"stayDateRange":["2023-01-02T00:00:00+00:00","2025-12-31T00:00:00+00:00"]}
    * match response.accommodationDeals[0].deals[*] contains {"dealCode":"5DOLLAROFF749","dealDescription":"$5 Off per night - QG","promotionalContentText":null,"promotionalContentImageUrl":null,"isDealApplied":true,"message":"","totalPrice":1195,"pricing":[{"date":"2024-02-05T00:00:00+00:00","baseRateAmountForTwoAdults":245,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":true,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal applied on 2/5/2024 12:00:00 AM"},{"date":"2024-02-06T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":false,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal not applicable on 2/6/2024 12:00:00 AM"},{"date":"2024-02-07T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":false,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal not applicable on 2/7/2024 12:00:00 AM"},{"date":"2024-02-08T00:00:00+00:00","baseRateAmountForTwoAdults":250,"additionalAdultAmount":15,"childAmount":10,"petAmount":5,"isDealApplied":false,"isAdditionalChargeRemoved":false,"additionalChargeAmount":50,"message":"Deal not applicable on 2/8/2024 12:00:00 AM"}],"stayDateRange":["2023-01-02T00:00:00+00:00","2025-12-31T00:00:00+00:00"]}
    #* match response.accommodationDeals[0].deals[1].isDealApplied == true
    #* match response.accommodationDeals[0].deals[1].totalPrice == 1710   
    #
## Will update scenarios below when test data are available

    #Scenario: Verify Stay 7, Pay 6 Deal Calculation
    ## Get Deal Validation
#
    #Given path 'api/accommodations/deals'
    #When request CreateDealValidation
    #When method post
    #Then status 200 
    #* match response.accommodationDeals[0].deals[1].dealCode == "AUTO Stay 7, Pay 6"
    #* match response.accommodationDeals[0].deals[1].isDealApplied == false
    #* match response.accommodationDeals[0].deals[1].totalPrice == 1800       
#
    #Scenario: Verify Stay Kids for Free Deal Calculation
    ## Get Deal Validation
#
    #Given path 'api/accommodations/deals'
    #When request CreateDealValidation
    #When method post
    #Then status 200 
    #* match response.accommodationDeals[0].deals[2].dealCode == "AUTO Stay Kids for Free"
    #* match response.accommodationDeals[0].deals[2].isDealApplied == true
    #* match response.accommodationDeals[0].deals[2].totalPrice == 594   
    #
    #Scenario: Verify Stay 5, Pay 3 Deal Calculation
    ## Get Deal Validation
#
    #Given path 'api/accommodations/deals'
    #When request CreateDealValidation
    #When method post
    #Then status 200    
    #* match response.accommodationDeals[0].deals[3].dealCode == "AUTO Stay 5, Pay 3"
    #* match response.accommodationDeals[0].deals[3].isDealApplied == true
    #* match response.accommodationDeals[0].deals[3].totalPrice == 1498
#
    #Scenario: Verify Stay 2, Save 20% Deal Calculation
    ## Get Deal Validation
#
    #Given path 'api/accommodations/deals'
    #When request CreateDealValidation
    #When method post
    #Then status 200
    #* match response.accommodationDeals[0].deals[4].dealCode == "AUTO Stay 2, Save 20%"
    #* match response.accommodationDeals[0].deals[4].isDealApplied == true
    #* match response.accommodationDeals[0].deals[4].totalPrice == 1440
#
    #Scenario: Verify 20% Midweek Deal Calculation
    ## Get Deal Validation
    #
    #Given path 'api/accommodations/deals'
    #When request CreateDealValidation
    #When method post
    #Then status 200
    #* match response.accommodationDeals[0].deals[5].dealCode == "AUTO 20% Off Midweek"
    #* match response.accommodationDeals[0].deals[5].isDealApplied == false
    #* match response.accommodationDeals[0].deals[5].totalPrice == 1560
     
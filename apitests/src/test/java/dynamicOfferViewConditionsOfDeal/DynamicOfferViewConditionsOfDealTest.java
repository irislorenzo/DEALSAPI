package dynamicOfferViewConditionsOfDeal;

import com.intuit.karate.junit5.Karate;

public class DynamicOfferViewConditionsOfDealTest {
	
	@Karate.Test
    Karate DynamicOfferNegative() {
        return Karate.run("DynamicOfferViewConditionsOfDeal").relativeTo(getClass());
    }
	
}
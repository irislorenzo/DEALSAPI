package dynamicOffer;

import com.intuit.karate.junit5.Karate;

public class DynamicOfferTest {

	@Karate.Test
    Karate DynamicOffer() {
        return Karate.run("DynamicOfferPositive").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DynamicOfferNegative() {
        return Karate.run("DynamicOfferNegative").relativeTo(getClass());
    }
	
}
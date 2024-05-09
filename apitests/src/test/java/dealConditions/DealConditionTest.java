package dealConditions;

import com.intuit.karate.junit5.Karate;

public class DealConditionTest {

	@Karate.Test
    Karate DealCondition() {
        return Karate.run("DealCondition").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealConditionContributor() {
        return Karate.run("DealConditionContributor").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealConditionReader() {
        return Karate.run("DealConditionReader").relativeTo(getClass());
    }
	
	
}
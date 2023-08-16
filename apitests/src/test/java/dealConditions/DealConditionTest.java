package dealConditions;

import com.intuit.karate.junit5.Karate;

public class DealConditionTest {

	@Karate.Test
    Karate DealCondition() {
        return Karate.run("DealCondition").relativeTo(getClass());
    }
	
	
}
package parks;

import com.intuit.karate.junit5.Karate;

public class ParksTest {

	@Karate.Test
    Karate DealCondition() {
        return Karate.run("Parks").relativeTo(getClass());
    }
	
	
}
package parksSearch;

import com.intuit.karate.junit5.Karate;

public class parksSearchRunnerTest {
	
	@Karate.Test
    Karate ParksSearchPositive() {
        return Karate.run("ParksSearch").relativeTo(getClass());
    }

	@Karate.Test
    Karate ParksSearchNegative() {
        return Karate.run("ParksSearchNegative").relativeTo(getClass());
    }
}
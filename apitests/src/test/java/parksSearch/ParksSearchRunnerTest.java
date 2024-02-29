package parksSearch;

import com.intuit.karate.junit5.Karate;

public class ParksSearchRunnerTest {
	
	@Karate.Test
    Karate ParksSearchPositive() {
        return Karate.run("ParksSearchPositive").relativeTo(getClass());
    }

	@Karate.Test
    Karate ParksSearchNegative() {
        return Karate.run("ParksSearchNegative").relativeTo(getClass());
    }
}
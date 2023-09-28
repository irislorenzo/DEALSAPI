package deals;

import com.intuit.karate.junit5.Karate;

public class DealRunnerTest {
	
	@Karate.Test
    Karate DealPositiveValidation() {
        return Karate.run("DealPositive").relativeTo(getClass());
    }

	@Karate.Test
    Karate DealNegativeValidation() {
        return Karate.run("DealNegative").relativeTo(getClass());
    }
}
package deals;

import com.intuit.karate.junit5.Karate;

public class DealNegativeRunnerTest {

	@Karate.Test
    Karate DealTemplate() {
        return Karate.run("DealNegative").relativeTo(getClass());
    }

}
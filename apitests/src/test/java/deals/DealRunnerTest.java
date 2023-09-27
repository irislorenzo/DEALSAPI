package deals;

import com.intuit.karate.junit5.Karate;

public class DealRunnerTest {

	@Karate.Test
    Karate DealTemplate() {
        return Karate.run("DealPositive").relativeTo(getClass());
    }

}
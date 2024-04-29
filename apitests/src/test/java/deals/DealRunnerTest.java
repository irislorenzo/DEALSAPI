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
	
	@Karate.Test
	Karate DealReaderValidation() {
      return Karate.run("DealsScenarioReader").relativeTo(getClass());
	}
	
	@Karate.Test
    Karate DealContributorValidation() {
        return Karate.run("DealsScenarioContributor").relativeTo(getClass());
    }


}
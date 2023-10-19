package dealCalculation;

import com.intuit.karate.junit5.Karate;

public class DealCalculationRunnerTest {
	
	@Karate.Test
    Karate DealPositiveValidation() {
        return Karate.run("DealValidationPositive").relativeTo(getClass());
    }

	@Karate.Test
    Karate DealNegativeValidation() {
        return Karate.run("DealValidationNegative").relativeTo(getClass());
    }
}
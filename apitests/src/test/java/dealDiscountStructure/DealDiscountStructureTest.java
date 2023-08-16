package dealDiscountStructure;

import com.intuit.karate.junit5.Karate;

public class DealDiscountStructureTest {

	@Karate.Test
    Karate DealDiscountStructure() {
        return Karate.run("DealDiscountStructure").relativeTo(getClass());
    }
}
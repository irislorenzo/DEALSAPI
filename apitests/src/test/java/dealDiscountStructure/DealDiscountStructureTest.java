package dealDiscountStructure;

import com.intuit.karate.junit5.Karate;

public class DealDiscountStructureTest {

	@Karate.Test
    Karate DealDiscountStructure() {
        return Karate.run("DealDiscountStructure").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealDiscountStructureContributor() {
        return Karate.run("DealDiscountStructureContributor").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealDiscountStructureReader() {
        return Karate.run("DealDiscountStructureReader").relativeTo(getClass());
    }
}
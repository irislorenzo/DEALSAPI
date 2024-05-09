package dealTemplate;

import com.intuit.karate.junit5.Karate;

public class DealTemplateTest {

	@Karate.Test
    Karate DealTemplate() {
        return Karate.run("DealTemplate").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealTemplateContributor() {
        return Karate.run("DealTemplateContributor").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealTemplateReader() {
        return Karate.run("DealTemplateReader").relativeTo(getClass());
    }

}
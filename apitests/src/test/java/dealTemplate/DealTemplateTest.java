package dealTemplate;

import com.intuit.karate.junit5.Karate;

public class DealTemplateTest {

	@Karate.Test
    Karate DealTemplate() {
        return Karate.run("DealTemplate").relativeTo(getClass());
    }

}
package dealCampaign;

import com.intuit.karate.junit5.Karate;

public class DealCampaignTest {

	@Karate.Test
    Karate DealCondition() {
        return Karate.run("DealCampaign").relativeTo(getClass());
    }
	
	
}
package dealCampaign;

import com.intuit.karate.junit5.Karate;

public class DealCampaignTest {

	@Karate.Test
    Karate DealCampaign() {
        return Karate.run("DealCampaign").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealCampaignContributor() {
        return Karate.run("DealCampaignContributor").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealCampaignReader() {
        return Karate.run("DealCampaignReader").relativeTo(getClass());
    }
	
}
package dealCampaign;

import com.intuit.karate.junit5.Karate;

public class DealCampaignTest {

	@Karate.Test
    Karate DealCampaign() {
        return Karate.run("DealCampaign").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealCampaignParticipants() {
        return Karate.run("DealCampaignParticipants").relativeTo(getClass());
    }
	
}
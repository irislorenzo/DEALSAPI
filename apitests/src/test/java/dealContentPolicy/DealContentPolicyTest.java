package dealContentPolicy;

import com.intuit.karate.junit5.Karate;

public class DealContentPolicyTest {

	@Karate.Test
    Karate DealContentPolicy() {
        return Karate.run("DealContentPolicy").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealContentPolicyContributor() {
        return Karate.run("DealContentPolicyContributor").relativeTo(getClass());
    }
	
	@Karate.Test
    Karate DealContentPolicyReader() {
        return Karate.run("DealContentPolicyReader").relativeTo(getClass());
    }
	
}
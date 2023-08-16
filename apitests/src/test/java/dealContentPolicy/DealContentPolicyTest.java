package dealContentPolicy;

import com.intuit.karate.junit5.Karate;

public class DealContentPolicyTest {

	@Karate.Test
    Karate DealContentPolicy() {
        return Karate.run("DealContentPolicy").relativeTo(getClass());
    }
	
}
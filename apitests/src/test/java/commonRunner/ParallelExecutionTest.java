package commonRunner;
//
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

class ParallelExecutionTest {


	@Test
	// tag any tests specifically written for the .net6 version with @net6
	// then we create another runner to include @net6
	// run:
	// mvn test -Dtest=ParallelExecutionTest -Dkarate.env=test
    void testParallel() {
        Results results = Runner.path(
        		"classpath:dealContentPolicy",
        		"classpath:dealDiscountStructure",
        		"classpath:dealConditions",
        		"classpath:parks",
        		"classpath:dealTemplate",
        		"classpath:deals",
        		"classpath:dealCalculation" ,
        		"classpath:dealCampaign",
        		"classpath:dynamicOffer",
        		"classpath:dynamicOfferViewConditionsOfDeal",
        		"classpath:parksSearch"
        	)
        		.outputCucumberJson(true)
        		.outputJunitXml(true)
        		.tags("~@deprecated", "~b2c", "~@3rdparty", "~@prod").parallel(2);
        // this will generate the cucumber html results
        generateReport(results.getReportDir());
        // Cause the runner to error if there are test failures
        // this means we can pick it up on the pipelines
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
        
    }
	
	public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"),
                "Membership SBE");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

class ParallelTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .tags("~@ignore")
                .outputCucumberJson(true)   // ← enables JSON output for reporting
                .parallel(5);

        generateCucumberReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    private void generateCucumberReport(String reportDir) {
        File targetDir = new File("target/cucumber-reports");

        // Collect all Karate-generated JSON files
        Collection<File> jsonFiles = FileUtils.listFiles(
                new File(reportDir), new String[]{"json"}, true
        );

        List<String> jsonPaths = new ArrayList<>();
        for (File file : jsonFiles) {
            jsonPaths.add(file.getAbsolutePath());
        }

        // Configure and build the report
        Configuration config = new Configuration(targetDir, "Vrqalabs-API-Automation-Test-Suite");

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
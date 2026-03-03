# API Automation — Karate (Java)

This repository is a sample API automation framework built with **Karate** and **Java** for **VRQA Labs**, a freelance automation consultancy. It showcases how we structure feature files, runners, and reporting configuration, and demonstrates realistic end-to-end API scenarios against a live event hub application.

🎯 If you're a potential client, think of this as a proof‑of‑concept. We can extend the same architecture to dozens of endpoints, multiple environments, and integrate with CI/CD for a complete automated delivery pipeline.

---

## 1. Prerequisites

Before running anything, make sure you have the following installed on your machine:

- **Java 21+** (with `JAVA_HOME` set correctly)
- **Maven 3.8+** (with `mvn` available on your PATH)
- **Git** (for cloning the repository)

No additional browser or server setup is required — Karate runs as a pure JVM test framework.

---

## 2. Local Setup

```bash
# clone the repo
git clone https://github.com/vrqalabs/api-automation-karate.git vrqalabs-api-automation-karate
cd vrqalabs-api-automation-karate

# run all tests in parallel (5 threads)
mvn clean verify

# run a specific feature tag only
mvn clean verify -Dkarate.options="--tags @login"

# run with debug output
mvn clean verify -e -X
```

After the run, open the HTML report at:

```
target/cucumber-reports/cucumber-html-reports/overview-features.html
```

---

## 3. Project Structure

```
.
├── src/
│   └── test/
│       └── java/
│           ├── TestRunner.java              # Global parallel runner (entry point)
│           ├── karate-config.js             # Global Karate configuration
│           ├── logback-test.xml             # Logging configuration for tests
│           └── features/
│               ├── register/
│               │   ├── register.feature     # User registration scenarios
│               ├── login/
│               │   ├── login.feature        # User login + token extraction
│               ├── me/
│               │   ├── me.feature           # Authenticated profile fetch
│
├── target/
│   ├── karate-reports/                      # Raw JSON output from Karate
│   └── cucumber-reports/                    # Masterthought HTML reports
│
├── pom.xml                                  # Maven build + dependency config
└── README.md
```

The framework follows a **domain-driven folder structure**, where each subdirectory maps directly to an API module (e.g. `eventhub/auth/`). Adding a new module is as simple as creating a new subfolder — the global runner picks it up automatically.

---

## 4. Application & Test Information

The application under test is the **EventHub API** — a RESTful backend exposing authentication and user management endpoints.

The repository currently contains three feature files covering the full auth flow:

### `register.feature`
1. Successful registration with valid credentials.
2. Duplicate email registration returns conflict error.
3. Missing email or password returns validation error.

### `login.feature`
1. Successful login returns a valid JWT token.
2. Wrong password returns 401 Unauthorized.
3. Unregistered email returns 401 Unauthorized.
4. Empty request body returns 400 Bad Request.

### `me.feature`
1. Valid token returns the authenticated user's profile.
2. Missing token returns 401 Unauthorized.
3. Invalid/expired token returns 401 Unauthorized.

> **Token chaining:** `me.feature` automatically calls `login.feature` in its `Background` block to obtain a live token before each scenario — mirroring a real user session flow.

Although only three feature files are present, the framework is easily extended. VRQA Labs can rapidly build out hundreds of scenarios, integrate data‑driven testing with external JSON/CSV files, and apply advanced Karate features such as mocking, schema validation, and performance testing.

---

## 5. Key Framework Features

| Feature | Detail |
|---|---|
| **Parallel execution** | 5 threads by default via `Runner.parallel(5)` — configurable |
| **Tag-based filtering** | Run subsets with `--tags @register`, `--tags @login`, etc. |
| **Token chaining** | Auth token flows automatically between feature files |
| **Negative test coverage** | Every endpoint tested for both happy path and error scenarios |
| **Rich HTML reports** | Masterthought Cucumber reports with pass/fail breakdown per feature |
| **Environment classification** | Reports stamped with Platform, Environment, and Suite metadata |
| **JSON schema matching** | Karate fuzzy matchers (`#string`, `#number`) validate response shape |

---

## 6. Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| Java | 21 | Runtime |
| Karate | 1.5.2 | API test DSL + runner |
| JUnit 5 | 5.11.0 | Test lifecycle management |
| Maven Surefire | 3.2.5 | Test execution plugin |
| Masterthought Cucumber Reporting | 5.8.0 | HTML report generation |
| Apache Commons IO | 2.15.1 | JSON file collection for reports |

---

## 7. Why VRQA Labs?

This sample repo reflects how VRQA Labs approaches API automation projects:

- **Domain-driven structure** separating feature files cleanly by API module.
- **Environment flexibility** — switch base URLs and credentials via Karate config or Maven properties.
- **Scalable design** — new endpoints or services slot in with zero changes to the runner.
- **Production-grade reporting** — rich HTML reports with feature-level drill-down, suitable for stakeholder review.
- **Realistic chaining** — tests mirror actual user flows, not just isolated endpoint pings.

If your team needs a robust Karate framework (or migration from RestAssured, Postman, or SoapUI), VRQA Labs offers full‑service implementation, training, and maintenance.

Contact us at [**connect.vrqalabs@outlook.com**] to discuss your automation needs.

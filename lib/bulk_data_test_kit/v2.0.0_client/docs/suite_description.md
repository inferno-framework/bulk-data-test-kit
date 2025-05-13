The Bulk Data Access v2.0.0 Client test suite validates the conformance of a client
to the [FHIR Bulk Data Access IG STU2](http://hl7.org/fhir/uv/bulkdata/STU2).

## Scope

These tests are a **DRAFT** intended to allow implementers to perform
preliminary checks of their systems against the requirements stated for Bulk Data client actors
and [provide feedback](https://github.com/inferno-framework/bulk-data-test-kit/issues)
on the tests. Future versions of these tests may verify other
requirements and may change the test verification logic.

## Running the Tests

### Quick Start

Bulk data access requires the use of SMART Backend Services for authentication.
In order to interact with Inferno's simulated bulk server, the tester must provide
the JSON Web Key Set (JWKS) containing the asymmetric signing key in the
**SMART JSON Web Key Set (JWKS)** input as either a URL that resolves
to a JWKS or a raw JWKS in JSON format. Additionally, testers may provide
a **Client Id** if they want their client assigned a specific one.

Once the client has been registered, it will need to obtain an access token
following the SMART Backend Services flow and use it when making bulk data requests.
f the client is not able to obtain an access token, see the *Demonstration* section
below for how to use the SMART server tests to obtain an access token that the client can use.

### Demonstration

To try out these tests without a Bulk Data client implementation, you may
run them using
- The SMART App Launch test suite to obtain an access token
- The [`Bulk Data Client - System Export Postman`](https://github.com/inferno-framework/bulk-data-test-kit/blob/main/lib/bulk_data_test_kit/v2.0.0_client/postman/collection.json)
  collection for making bulk data requests.

This collection includes requests to kick-off an export, poll the status endpoint
(respecting the `retry-after` header), download the first output result, and then delete the export.

To run the demonstration:
1. Start an Inferno session of the Bulk Data Client test suite.
1. In a second tab, start an instance of the SMART App Launch STU2.2 test suite and select the "Demo: Run Against the SMART 
   Client Suite (Confidential Asymmetric)" preset.
1. Select the "Backend Services" group and click the "RUN TESTS" button, but don't run the tests yet.
1. Back in the Bulk Data test session, click the "RUN ALL TESTS" button and fill in the following inputs
   using the values from the SMART App Tests:
   - **Client Id**: from the SMART **Client ID** input
   - **SMART Confidential Asymmetric JSON Web Key Set (JWKS)**: from the "JWK Set URL" in the top of the open input
     dialog in the SMART test session.
1. Click the "Submit" button. The simulated server will start waiting for requests.
1. Copy the base url that appears in the bulk data wait dialog and put it into the **FHIR Endpoint** input in the
   SMART test session and click the "SUBMIT" button. The tests should complete with some failures and some passes.
1. Copy the access token from the `bearer_token` output of test **3.2.06** "Authorization request response body
   contains required information encoded in JSON".
1. Open Postman and import the [Postman collection](https://github.com/inferno-framework/bulk-data-test-kit/blob/main/lib/bulk_data_test_kit/v2.0.0_client/postman/collection.json)
   if not already done.
1. Set the `access_token` variable equal to the value extracted from the SMART tests.
1. Run the collection.
1. Once the postman collection has run, click the "Click here" link in the Inferno wait dialog modal to evaluate the requests and generate the results.
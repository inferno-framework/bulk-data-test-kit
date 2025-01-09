The Bulk Data Access v2.0.0 Client test suite validates the conformance of a client
to the [FHIR Bulk Data Access IG STU2](http://hl7.org/fhir/uv/bulkdata/STU2).

## Scope

These tests are a **DRAFT** intended to allow implementers to perform
preliminary checks of their systems against the requirements stated for Bulk Data client actors
and [provide feedback](https://github.com/inferno-framework/bulk-data-test-kit/issues)
on the tests. Future versions of these tests may verify other
requirements and may change the test verification logic.

### Sample Execution - Postman

To try out these tests without a Bulk Data client implementation, you may
run them using [this "bulk data client system export" Postman collection](https://github.com/inferno-framework/bulk-data-test-kit/blob/main/lib/bulk_data_test_kit/v2.0.0_client/postman/system_export.postman_collection.json) and [this "bulk data client delete" Postman collection](https://github.com/inferno-framework/bulk-data-test-kit/blob/main/lib/bulk_data_test_kit/v2.0.0_client/postman/delete.postman_collection.json).

To run client tests against one of the Postman collections:
1. Start an Inferno session of the Bulk Data Client test suite.
2. Navigate to either the export tests group or the delete tests group (depending on which Postman collection you want to use).
3. Click the "Run Tests" button in the upper right and select the "System Level Export" option for export type.
4. Click the "Submit" button. The simulated server will then be waiting for an interaction.
5. Open Postman and import the relevant Postman collection.
6. Set the `kickoff-base-url` variable equal to the base URL provided by inferno.
7. Run the collection.
8. Once the postman collection has run, click the "Click here" link in the wait dialog to evaluate the requests.

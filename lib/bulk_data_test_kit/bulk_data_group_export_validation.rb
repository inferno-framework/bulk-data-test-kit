require_relative 'bulk_export_validation_tester'

module BulkDataTestKit
  class BulkDataGroupExportValidation < Inferno::TestGroup
    title 'Group Compartment Export Validation Tests'
    short_description 'Verify that the exported data conforms to the US Core Implementation Guide.'
    description <<~DESCRIPTION
      Verify that Group compartment export from the Bulk Data server follow US Core Implementation Guide
    DESCRIPTION

    id :bulk_data_group_export_validation

    input :status_output, :requires_access_token, :bearer_token, :bulk_download_url
    input :lines_to_validate,
          title: 'Limit validation to a maximum resource count',
          description: 'To validate all, leave blank.',
          optional: true

    test from: :tls_version_test do
      title 'Bulk Data Server is secured by transport layer security'
      description <<~DESCRIPTION
        [§170.315(g)(10) Test Procedure]
        (https://www.healthit.gov/test-method/standardized-api-patient-and-population-services)
        requires that all exchanges described herein between a client and a
        server SHALL be secured using Transport Layer Security  (TLS)
        Protocol Version 1.2 (RFC5246).
      DESCRIPTION
      id :bulk_file_server_tls_version

      config(
        inputs: { url: { name: :bulk_download_url } },
        options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
      )
    end

    test do
      include BulkDataTestKit::BulkExportValidationTester

      title 'NDJSON download requires access token if requireAccessToken is true'
      description <<~DESCRIPTION
        If the requiresAccessToken field in the Complete Status body is set to true, the request SHALL include a valid#{' '}
        access token.

        [FHIR R4 Security](https://www.hl7.org/fhir/security.html#AccessDenied) and
        [The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://tools.ietf.org/html/rfc6750#section-3.1)
        recommend using HTTP status code 401 for invalid token but also allow the actual result be controlled by policy#{' '}
        and context.
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#file-request'

      input :bulk_download_url

      run do
        ndjson_download_requiresAccessToken_check(bulk_data_download_url: bulk_download_url, bulk_requires_access_token: requires_access_token)
      end
    end

    test do
      include BulkDataTestKit::BulkExportValidationTester

      title 'All resources returned are valid FHIR resources'
      description <<~DESCRIPTION
        This test verifies that the resources returned from bulk data export
        conform to the US Core Patient profile. This includes checking for missing data
        elements and value set verification.
      DESCRIPTION
      # link 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'

      run do
        perform_bulk_export_validation(bulk_status_output: status_output, bulk_requires_access_token: requires_access_token)
      end
    end

    test do
      include BulkDataTestKit::BulkExportValidationTester

      title 'Group export has at least two patients'
      description <<~DESCRIPTION
        This test verifies that the Group export has at least two patients.
      DESCRIPTION
      # link 'http://ndjson.org/'

      run do
        export_multiple_patients_check
      end
    end
  end
end

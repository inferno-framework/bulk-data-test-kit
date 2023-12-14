require 'tls_test_kit'
require_relative '../export_kick_off_performer'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientExportGroup < Inferno::TestGroup
      title 'All Patient Export Tests'
      short_description 'Verify that the system supports all patient export.'
      description <<~DESCRIPTION
        Verify that system level export on the Bulk Data server follow the Bulk Data Access Implementation Guide
      DESCRIPTION
      id :bulk_data_patient_export_group

      input :bearer_token,
            title: 'Bulk Data Authorization Bearer Token',
            description: 'The authorization bearer token for the Bulk FHIR server.'
      input :bulk_server_url,
            title: 'Bulk Data FHIR URL',
            description: 'The URL of the Bulk FHIR server.'
      input :bulk_timeout,
            title: 'Export Times Out after (1-600)',
            description: <<~DESCRIPTION,
              While testing, Inferno waits for the server to complete the exporting task. If the calculated totalTime is
              greater than the timeout value specified here, Inferno bulk client stops testing. Please enter an integer
              for the maximum wait time in seconds. If timeout is less than 1, Inferno uses default value 180. If the
                timeout is greater than 600 (10 minutes), Inferno uses the maximum value 600.
            DESCRIPTION
            default: 180

      output :requires_access_token, :status_output, :bulk_download_url

      fhir_client :bulk_server do
        url :bulk_server_url
      end

      http_client :bulk_server do
        url :bulk_server_url
      end

      test from: :tls_version_test do
        title 'Bulk Data Server is secured by transport layer security'
        description <<~DESCRIPTION
          [§170.315(g)(10) Test
          Procedure](https://www.healthit.gov/test-method/standardized-api-patient-and-population-services)
          requires that all exchanges described herein between a client and a
          server SHALL be secured using Transport Layer Security (TLS) Protocol
          Version 1.2 (RFC5246).
        DESCRIPTION
        id :bulk_data_server_tls_version

        config(
          inputs: { url: { name: :bulk_server_url } },
          options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
        )
      end

      test do
        title 'Bulk Data Server declares support for Group export operation in CapabilityStatement'
        description <<~DESCRIPTION
          This test verifies that the Bulk Data Server declares support for
          Group/[id]/$export operation in its server CapabilityStatement.

          Given flexibility in the FHIR specification for declaring constrained
          OperationDefinitions, this test only verifies that the server declares
          any operation on the Group resource.  It does not verify that it
          declares the standard group export OperationDefinition provided in the
          Bulk Data specification, nor does it attempt to resolve any non-standard
          OperationDefinitions to verify if it is a constrained version of the
          standard OperationDefintion.

          This test will provide a warning if no operations are declared at
          `Group/[id]/$export`, via the
          `CapabilityStatement.rest.resource.operation.name` element.  It will
          also provide an informational message if an operation on the Group
          resource exists, but does not point to the standard OperationDefinition
          canonical URL:
          http://hl7.org/fhir/uv/bulkdata/OperationDefinition/group-export

          Additionally, this test provides a warning if the bulk data server does
          not include the following URL in its `CapabilityStatement.instantiates`
          element: http://hl7.org/fhir/uv/bulkdata/CapabilityStatement/bulk-data
        DESCRIPTION

        include BulkDataExportTester

        run do
          check_export_support('Patient', 'patient-export', 'http://hl7.org/fhir/uv/bulkdata/OperationDefinition/patient-export')
        end
      end

      test do
        title 'Bulk Data Server rejects $export request without authorization'
        description <<~DESCRIPTION
          The FHIR server SHALL limit the data returned to only those FHIR resources for which the client is authorized.

          [FHIR R4 Security](https://www.hl7.org/fhir/security.html#AccessDenied) and
          [The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://tools.ietf.org/html/rfc6750#section-3.1)
          recommend using HTTP status code 401 for invalid token but also allow the actual result be controlled by policy and context.
        DESCRIPTION
        # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-kick-off-request'

        include BulkDataExportTester
        include ExportKickOffPerformer

        run do
          rejects_without_authorization("Patient/$export")
        end
      end

      test do
        title 'Bulk Data Server returns "202 Accepted" and "Content-location" for $export operation'
        description <<~DESCRIPTION
          Response - Success

          * HTTP Status Code of 202 Accepted
          * Content-Location header with the absolute URL of an endpoint for subsequent status requests (polling location)
        DESCRIPTION
        # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#response---success'

        include BulkDataExportTester
        include ExportKickOffPerformer

        output :polling_url

        run do
          export_kick_off_success("Patient/$export")
        end
      end

      test do
        title 'Bulk Data Server returns "202 Accepted" or "200 OK" for status check'
        description <<~DESCRIPTION
          Clients SHOULD follow an exponential backoff approach when polling for status. Servers SHOULD respond with

          * In-Progress Status: HTTP Status Code of 202 Accepted
          * Complete Status: HTTP status of 200 OK and Content-Type header of application/json

          The JSON object of Complete Status SHALL contain these required field:

          * transactionTime, request, requiresAccessToken, output, and error
        DESCRIPTION
        # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-status-request'

        include BulkDataExportTester
        
        input :polling_url

        output :status_response, :requires_access_token

        run do
          export_status_check_success
        end
      end

      test do
        title 'Bulk Data Server returns output with type and url for status complete'
        description <<~DESCRIPTION
          The value of output field is an array of file items with one entry for each generated file.
          If no resources are returned from the kick-off request, the server SHOULD return an empty array.

          Each file item SHALL contain the following fields:

          * type - the FHIR resource type that is contained in the file.

          Each file SHALL contain resources of only one type, but a server MAY create more than one file for each resource type returned.

          * url - the path to the file. The format of the file SHOULD reflect that requested in the _outputFormat parameter of the initial kick-off request.
        DESCRIPTION
        # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#response---complete-status'

        include BulkDataExportTester

        input :status_response

        output :status_output, :bulk_download_url

        run do
          check_bulk_data_output
        end
      end
    end
  end
end

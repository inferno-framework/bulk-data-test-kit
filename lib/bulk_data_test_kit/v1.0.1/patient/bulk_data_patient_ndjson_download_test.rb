require_relative '../../bulk_export_validation_tester'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientNDJSONDownloadTest < Inferno::Test
      include BulkDataTestKit::BulkExportValidationTester

      id :bulk_data_patient_ndjson_download

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

      input :patient_bulk_download_url

      run do
        ndjson_download_requiresAccessToken_check(bulk_data_download_url: patient_bulk_download_url, bulk_requires_access_token: patient_requires_access_token)
      end
    end
  end
end
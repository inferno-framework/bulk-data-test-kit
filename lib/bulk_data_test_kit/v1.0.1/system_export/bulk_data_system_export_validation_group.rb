# frozen_string_literal: true

require_relative '../bulk_data_multiple_patients_test'
require_relative '../bulk_data_ndjson_download_test'
require_relative '../bulk_data_valid_resources_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSystemExportValidation < Inferno::TestGroup
      title 'System Level Export Validation Tests'
      short_description 'Verify that the data returned from system level export conforms to the base FHIR standard.'
      description <<~DESCRIPTION
        Verify that system level export from the Bulk Data server follow the base FHIR standard
      DESCRIPTION

      id :bulk_data_system_export_validation

      input :bulk_auth_info,
            type: :auth_info,
            options: { mode: 'access' }
      input :system_status_output, :system_requires_access_token, :system_bulk_download_url
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
          inputs: { url: { name: :system_bulk_download_url } },
          options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
        )
      end

      test from: :bulk_data_ndjson_download,
           id: :bulk_data_system_ndjson_download,
           config: {
             inputs: {
               bulk_download_url: { name: :system_bulk_download_url },
               requires_access_token: { name: :system_requires_access_token }
             }
           }

      test from: :bulk_data_valid_resources,
           id: :bulk_data_system_valid_resources,
           config: {
             inputs: {
               status_output: { name: :system_status_output },
               requires_access_token: { name: :system_requires_access_token }
             }
           }

      test from: :bulk_data_multiple_patients,
           id: :bulk_data_system_multiple_patients
    end
  end
end

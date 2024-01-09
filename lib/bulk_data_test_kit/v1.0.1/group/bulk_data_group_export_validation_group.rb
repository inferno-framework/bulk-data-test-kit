require_relative '../bulk_data_multiple_patients_test'
require_relative '../bulk_data_ndjson_download_test'
require_relative '../bulk_data_valid_resources_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupExportValidation < Inferno::TestGroup
      title 'Group Compartment Export Validation Tests'
      short_description 'Verify that the data from Group export conforms to the base FHIR standard.'
      description <<~DESCRIPTION
        Verify that Group compartment export from the Bulk Data server follow the base FHIR standard
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

      test from: :bulk_data_ndjson_download,
        id: :bulk_data_group_ndjson_download
      
      test from: :bulk_data_valid_resources,
        id: :bulk_data_group_valid_resources
      
      test from: :bulk_data_multiple_patients,
        id: :bulk_data_group_multiple_patients

    end
  end
end

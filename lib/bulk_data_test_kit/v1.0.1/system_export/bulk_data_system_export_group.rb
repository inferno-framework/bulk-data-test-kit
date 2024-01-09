require 'tls_test_kit'
require_relative 'bulk_data_system_export_operation_support_test.rb'
require_relative 'bulk_data_system_export_no_auth_test.rb'
require_relative 'bulk_data_system_export_kick_off_test.rb'
require_relative 'bulk_data_system_export_status_check_test.rb'
require_relative 'bulk_data_system_export_output_check_test.rb'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSystemExportGroup < Inferno::TestGroup
      title 'System Level Export Tests'
      short_description 'Verify that the system supports bulk system level export of data, whether or not it is associated with a patient.'
      description <<~DESCRIPTION
        Verify that system level export on the Bulk Data server follow the Bulk Data Access Implementation Guide
      DESCRIPTION
      id :bulk_data_system_export_group

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

      output :system_export_requires_access_token, :system_export_status_output, :system_export_bulk_download_url

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

      test from: :bulk_data_system_export_operation_support
      test from: :bulk_data_system_export_no_auth_reject
      test from: :bulk_data_system_export_kick_off
      test from: :bulk_data_system_export_status_check
      test from: :bulk_data_system_export_output_check
    end
  end
end

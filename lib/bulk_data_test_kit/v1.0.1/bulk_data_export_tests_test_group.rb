# frozen_string_literal: true

require_relative 'bulk_data_group_export_test_group'
require_relative 'bulk_data_patient_export_test_group'
require_relative 'bulk_data_system_export_test_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartBackendServicesGroupV101 < Inferno::TestGroup
      id :bulk_data_export_tests_v101
      title 'Bulk Data Export Tests'

      input :bulk_server_url

      group do
        id :bulk_data_server_tests
        title 'Bulk Data Server TLS Tests'
        run_as_group

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
      end

      group from: :bulk_data_group_export_v101
      group from: :bulk_data_patient_export_v101
      group from: :bulk_data_system_export_v101
    end
  end
end

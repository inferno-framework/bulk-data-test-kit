# frozen_string_literal: true

require_relative '../../version'

require_relative './endpoints/delete'
require_relative './endpoints/kick_off'
require_relative './endpoints/output'
require_relative './endpoints/status'

require_relative './groups/export'
require_relative './groups/delete'

module BulkDataTestKit
  module BulkDataV200
    module Client
      # Bulk Data Access v2.0.0 Client Test Suite
      class BulkDataClientTestSuite < Inferno::TestSuite
        include URLs

        title 'Bulk Data Access v2.0.0 Client'

        description File.read(File.join(__dir__, 'docs', 'suite_description.md'))

        version VERSION

        id :bulk_data_v200_client

        links [
          {
            label: 'Report Issue',
            url: 'https://github.com/inferno-framework/bulk-data-test-kit/issues/'
          },
          {
            label: 'Open Source',
            url: 'https://github.com/inferno-framework/bulk-data-test-kit/'
          },
          {
            label: 'Download',
            url: 'https://github.com/inferno-framework/bulk-data-test-kit/releases'
          },
          {
            label: 'Implementation Guide',
            url: 'https://hl7.org/fhir/uv/bulkdata/STU2/'
          }
        ]

        suite_endpoint :get, PATIENT_KICKOFF_ROUTE, Endpoints::KickOff
        suite_endpoint :get, GROUP_KICKOFF_ROUTE, Endpoints::KickOff
        suite_endpoint :get, SYSTEM_KICKOFF_ROUTE, Endpoints::KickOff
        suite_endpoint :get, STATUS_ROUTE, Endpoints::Status
        suite_endpoint :get, OUTPUT_ROUTE, Endpoints::Output
        suite_endpoint :delete, STATUS_ROUTE, Endpoints::Delete

        resume_test_route :get, RESUME_PASS_PATH do |request|
          request.query_parameters['id']
        end

        group from: :bulk_data_client_export_group
        group from: :bulk_data_client_delete_group
      end
    end
  end
end

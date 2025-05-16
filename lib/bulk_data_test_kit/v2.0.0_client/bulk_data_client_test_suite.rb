# frozen_string_literal: true
require 'smart_app_launch_test_kit'

require_relative '../version'
require_relative 'tags'
require_relative 'urls'
require_relative 'export_types'
require_relative 'server_proxy'

require_relative 'endpoints/delete'
require_relative 'endpoints/kick_off'
require_relative 'endpoints/output'
require_relative 'endpoints/status'

require_relative 'bulk_data_client_registration_group'
require_relative 'bulk_data_client_export_group'
require_relative 'bulk_data_client_auth_verification_group'

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientTestSuite < Inferno::TestSuite
      title 'Bulk Data Access v2.0.0 Client'

      description File.read(File.join(__dir__, 'docs', 'suite_description.md'))

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

      requirement_sets(
        {
          identifier: 'hl7.fhir.uv.bulkdata_2.0.0',
          title: 'Bulk Data Access IG v2.0.0',
          actor: 'Client'
        },
        {
          identifier: 'hl7.fhir.uv.bulkdata_2.0.0',
          title: 'Bulk Data Access IG v2.0.0',
          actor: 'Server/Client'
        }
      )

      input :export_type,
            title: 'Export Type',
            description: 'The export endpoint type to test against.',
            type: 'radio',
            default: SYSTEM_EXPORT_TYPE,
            options: {
              list_options: [
                {
                  label: 'All Patients',
                  value: PATIENT_EXPORT_TYPE
                },
                {
                  label: 'Group of Patients',
                  value: GROUP_EXPORT_TYPE
                },
                {
                  label: 'System Level Export',
                  value: SYSTEM_EXPORT_TYPE
                }
              ]
            }

      input :group_id,
            title: 'Group ID',
            description: 'If using the Group endpoint, the ID that represents the data set that will be used.',
            type: 'radio',
            options: {
              list_options: [
                {
                  label: 'PDex Data',
                  value: 'pdex-Group'
                },
                {
                  label: 'CARIN Data',
                  value: 'carin-Group'
                },
                {
                  label: 'US Core Data',
                  value: '1a'
                },
                {
                  label: 'PDex, CARIN, and US Core Data',
                  value: 'combo-Group'
                }
              ]
            }

      # SMART Backend Services server simulation
      route(:get, SMARTAppLaunch::SMART_DISCOVERY_PATH, lambda { |_env|
        SMARTAppLaunch::MockSMARTServer.smart_server_metadata(id)
      })
      suite_endpoint :post, SMARTAppLaunch::TOKEN_PATH, SMARTAppLaunch::MockSMARTServer::TokenEndpoint

      suite_endpoint :get, PATIENT_KICKOFF_ROUTE, Endpoints::KickOff
      suite_endpoint :get, GROUP_KICKOFF_ROUTE, Endpoints::KickOff
      suite_endpoint :get, SYSTEM_KICKOFF_ROUTE, Endpoints::KickOff
      suite_endpoint :get, STATUS_ROUTE, Endpoints::Status
      suite_endpoint :get, OUTPUT_ROUTE, Endpoints::Output
      suite_endpoint :delete, STATUS_ROUTE, Endpoints::Delete

      resume_test_route :get, RESUME_PASS_ROUTE do |request|
        request.query_parameters['id']
      end

      group from: :bulk_data_client_registration
      group from: :bulk_data_client_export_group
      group from: :bulk_data_client_auth_verification
    end
  end
end

# frozen_string_literal: true

require 'smart_app_launch_test_kit'
# require 'smart_app_launch/smart_stu2_suite'
# require 'smart_app_launch/backend_services_authorization_group'
# require 'smart_app_launch/smart_tls_test'

require_relative 'bulk_data_smart_discovery_v101_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartBackendServicesV101Group < Inferno::TestGroup
      title 'SMART Backend Services'
      id :bulk_data_smart_backend_services_v101
      optional

      group from: :bulk_data_smart_discovery_v101,
            config: {
              inputs: { url: { name: :bulk_server_url }, encryption_algorithm: { locked: true } }
            }

      group from: :backend_services_authorization,
            config: {
              inputs: { url: { name: :bulk_server_url }, encryption_algorithm: { locked: true } }
            },
            run_as_group: true
    end
  end
end

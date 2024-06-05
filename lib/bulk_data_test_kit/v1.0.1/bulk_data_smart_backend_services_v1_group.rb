# frozen_string_literal: true

require 'smart_app_launch/smart_stu2_suite'
require_relative 'bulk_data_smart_discovery_v1_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartBackendServicesV1Group < Inferno::TestGroup
      title 'SMART Backend Services'
      id :bulk_data_smart_backend_services_v101
      optional

      group from: :bulk_data_smart_discovery_v1,
            config: {
              inputs: { url: { name: :bulk_server_url } }
            }

      group from: :backend_services_authorization
    end
  end
end

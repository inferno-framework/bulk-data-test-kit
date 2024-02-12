# frozen_string_literal: true

require 'smart_app_launch/smart_stu2_suite'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSmartBackendServicesGroup < Inferno::TestGroup
      title 'SMART Backend Services'
      id :bulk_data_smart_backend_services
      run_as_group
      optional

      group from: :smart_discovery_stu2,
            config: {
              inputs: { url: { name: :bulk_server_url } }
            }

      group from: :backend_services_authorization
    end
  end
end

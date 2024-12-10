# frozen_string_literal: true

require 'smart_app_launch/smart_stu2_suite'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSmartBackendServicesV200Group < Inferno::TestGroup
      title 'SMART Backend Services'
      id :bulk_data_smart_backend_services_v200
      run_as_group
      optional

      group from: :smart_discovery_stu2,
            config: {
              inputs: { url: { name: :bulk_server_url } }
            }

      group from: :backend_services_authorization,
            verifies_requirements: ['hl7.fhir.uv.bulkdata_2.0.0@2','hl7.fhir.uv.bulkdata_2.0.0@4', 'hl7.fhir.uv.bulkdata_2.0.0@19', 'hl7.fhir.uv.bulkdata_2.0.0@218']
    end
  end
end

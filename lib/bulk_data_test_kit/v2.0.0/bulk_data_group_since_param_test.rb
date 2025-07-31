# frozen_string_literal: true

require_relative 'bulk_data_since_param_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupSinceParamTest < BulkDataV200::BulkDataSinceParamTest
      id :since_in_group_export_response

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@53', 'hl7.fhir.uv.bulkdata_2.0.0@254'

      input :group_id

      config(
        options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
      )
    end
  end
end

# frozen_string_literal: true

require_relative 'bulk_data_outputFormat_param_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupOutputFormatParamTest < BulkDataV200::BulkDataOutputFormatParamTest
      id :output_format_in_group_export_response
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@251'

      input :group_id

      config(
        options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
      )
    end
  end
end

# frozen_string_literal: true

require_relative '../../v1.0.1/group/bulk_data_group_export_cancel_group'
require_relative '../bulk_data_export_cancel_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportCancelGroup < BulkDataV101::BulkDataGroupExportCancelGroup
      id :bulk_data_group_export_cancel_group_stu2

      test from: :bulk_data_export_cancel_stu2,
           id: :bulk_data_group_export_cancel_stu2

      # re-using the stu1 group for stu2, but need to update requirements in the children to v2.0.0
      children.find { |child| child.id.ends_with?('bulk_data_export_group_cancel') }
        .verifies_requirements('hl7.fhir.uv.bulkdata_2.0.0@305', 'hl7.fhir.uv.bulkdata_2.0.0@306')
    end
  end
end

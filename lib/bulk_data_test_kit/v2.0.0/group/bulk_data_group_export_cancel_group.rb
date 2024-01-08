require_relative '../../v1.0.1/group/bulk_data_group_export_cancel_group'
require_relative 'bulk_data_group_export_cancel_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportCancelGroup < BulkDataV101::BulkDataGroupExportCancelGroup
      id :bulk_data_group_export_cancel_group_stu2

      test from: :bulk_data_group_export_cancel_stu2
    end
  end
end

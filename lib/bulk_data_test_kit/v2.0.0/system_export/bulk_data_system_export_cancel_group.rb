require_relative '../../v1.0.1/system_export/bulk_data_system_export_cancel_group'
require_relative 'bulk_data_system_export_cancel_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportCancelGroup < BulkDataV101::BulkDataSystemExportCancelGroup
      id :bulk_data_system_export_cancel_group_stu2

      test from: :bulk_data_system_export_cancel_stu2
    end
  end
end

require_relative '../../v1.0.1/system_export/bulk_data_system_export_group'
require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportGroup < BulkDataV101::BulkDataSystemExportGroup
      title 'System Level Export Tests STU2'
      id :bulk_data_system_export_group_stu2

      config(options: { require_absolute_urls_in_output: true })
    end
  end
end

require_relative '../../v1.0.1/group/bulk_data_group_export_group'
require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportGroup < BulkDataV101::BulkDataGroupExportGroup
      title 'Group Compartment Export Tests STU2'
      id :bulk_data_group_export_group_stu2

      config(options: { require_absolute_urls_in_output: true })
    end
  end
end

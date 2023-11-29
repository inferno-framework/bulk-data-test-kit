require_relative '../v1.0.1/bulk_data_group_export_group'
require_relative '../export_kick_off_performer'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportSTU2 < BulkDataV101::BulkDataGroupExportSTU1
      title 'Group Compartment Export Tests STU2'
      id :bulk_data_group_export_group_stu2

      config(options: { require_absolute_urls_in_output: true })
    end
  end
end

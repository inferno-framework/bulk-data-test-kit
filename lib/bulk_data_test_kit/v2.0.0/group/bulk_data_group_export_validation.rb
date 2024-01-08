require_relative '../../v1.0.1/group/bulk_data_group_export_validation_group'
require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupExportValidation < BulkDataV101::BulkDataGroupExportValidation
      title 'Group Compartment Export Validation Tests STU2'
      id :bulk_data_group_export_validation_stu2
    end
  end
end

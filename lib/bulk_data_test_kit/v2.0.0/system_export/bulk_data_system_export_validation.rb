require_relative '../../v1.0.1/system_export/bulk_data_system_export_validation_group'
require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemxportValidation < BulkDataV101::BulkDataSystemExportValidation
      title 'System Level Export Validation Tests STU2'
      id :bulk_data_system_export_validation_stu2
    end
  end
end

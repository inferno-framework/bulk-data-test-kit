require_relative '../../v1.0.1/patient/bulk_data_patient_export_validation_group'
require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportValidation < BulkDataV101::BulkDataPatientExportValidation
      title 'All Patient Export Validation Tests STU2'
      id :bulk_data_patient_export_validation_stu2
    end
  end
end

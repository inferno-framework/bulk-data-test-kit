require_relative '../v1.0.1/bulk_data_patient_export_group'
require_relative '../bulk_data_export_tester.rb'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientExportGroup < BulkDataV101::BulkDataPatientExportGroup
      title 'All Patient Export Tests STU2'
      id :bulk_data_patient_export_group_stu2

      config(options: { require_absolute_urls_in_output: true })
    end
  end
end

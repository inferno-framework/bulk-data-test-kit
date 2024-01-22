require_relative 'patient/bulk_data_patient_export_cancel_group'
require_relative 'patient/bulk_data_patient_export_parameters_group'
require_relative '../v1.0.1/patient/bulk_data_patient_export_group'
require_relative '../v1.0.1/patient/bulk_data_patient_export_validation_group'


module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientTestGroup < Inferno::TestGroup
      title 'Bulk Data Patient API Tests'
      id :bulk_data_patient_export_v200
      run_as_group
      
      description %(
        The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server) 
        to support required Bulk Data $export operation.                  
      )

      group from: :bulk_data_patient_export_group,
      title: 'Patient Export Tests STU2',
      id: :bulk_data_patient_export_group_stu2,
      config: {
        options: { require_absolute_urls_in_output: true }
      }

      group from: :bulk_data_patient_export_validation,
        title: 'All Patient Export Validation Tests STU2',
        id: :bulk_data_patient_export_validation_stu2

      group from: :bulk_data_patient_export_cancel_group_stu2
      group from: :bulk_data_patient_export_parameters_group
    end
  end
end
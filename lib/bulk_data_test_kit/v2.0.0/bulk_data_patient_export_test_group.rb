require_relative 'patient/bulk_data_patient_export_group'
require_relative 'patient/bulk_data_patient_export_cancel_group'
require_relative 'patient/bulk_data_patient_export_parameters_group'
require_relative '../bulk_data_patient_export_validation'


module BulkDataTestKit
  module BulkDataV200
    class BulkDataPatientTestGroup < Inferno::TestGroup
      title 'Bulk Data Patient API Tests'
      id :bulk_data_patient_export_v200
      
      description %(
        The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server) 
        to support required Bulk Data $export operation.                  
      )
      
      input_order :bearer_token,
                  :group_id,
                  :bulk_patient_ids_in_group,
                  :bulk_device_types_in_group,
                  :lines_to_validate,
                  :bulk_timeout
      
      group from: :bulk_data_patient_export_group_stu2
      group from: :bulk_data_patient_export_validation
      group from: :bulk_data_patient_export_cancel_group_stu2
      group from: :bulk_data_patient_export_parameters_group
    end
  end
end
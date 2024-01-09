require_relative 'system_export/bulk_data_system_export_group'
require_relative 'system_export/bulk_data_system_export_cancel_group'
require_relative 'system_export/bulk_data_system_export_parameters_group'
require_relative 'system_export/bulk_data_system_export_validation'


module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportTestGroup < Inferno::TestGroup
      title 'Bulk Data System Level Export API Tests'
      id :bulk_data_system_export_v200
      run_as_group
      
      description %(
        The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server) 
        to support required Bulk Data $export operation.                  
      )
      
      input_order :bearer_token,
                  :group_id,
                  :lines_to_validate,
                  :bulk_timeout
      
      group from: :bulk_data_system_export_group_stu2
      group from: :bulk_data_system_export_validation
      group from: :bulk_data_system_export_cancel_group_stu2
      group from: :bulk_data_system_export_parameters_group
    end
  end
end
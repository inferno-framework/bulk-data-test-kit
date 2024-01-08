require_relative 'group/bulk_data_group_export_group'
require_relative 'group/bulk_data_group_export_cancel_group'
require_relative 'group/bulk_data_group_export_parameters_group'
require_relative 'group/bulk_data_group_export_validation'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataGroupTestGroup < Inferno::TestGroup
      title 'Bulk Data Group API Tests'
      id :bulk_data_group_export_v200
      run_as_group

      description %(
          The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server) 
          to support required Bulk Data Group $export operation.                  
      )
      input_order :bulk_server_url,
                  :bearer_token,
                  :group_id,
                  :lines_to_validate,
                  :bulk_timeout


      group from: :bulk_data_group_export_group_stu2
      group from: :bulk_data_group_export_validation
      group from: :bulk_data_group_export_cancel_group_stu2
      group from: :bulk_data_group_export_parameters_group
    end
  end
end
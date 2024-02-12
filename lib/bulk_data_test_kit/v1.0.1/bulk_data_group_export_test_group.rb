# frozen_string_literal: true

require_relative 'group/bulk_data_group_export_group'
require_relative 'group/bulk_data_group_export_cancel_group'
require_relative 'group/bulk_data_group_export_validation_group'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupTestGroup < Inferno::TestGroup
      title 'Bulk Data Group API Tests'
      id :bulk_data_group_export_v101
      run_as_group

      description %(
          The Bulk Data Access API Tests evaluate the ability of a system (Bulk Data Server)
          to support required Bulk Data Group $export operation.
      )

      group from: :bulk_data_group_export_group
      group from: :bulk_data_group_export_validation
      group from: :bulk_data_group_export_cancel_group
    end
  end
end

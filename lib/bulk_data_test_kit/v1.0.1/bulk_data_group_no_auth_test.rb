# frozen_string_literal: true

require_relative 'bulk_data_no_auth_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupExportNoAuthRejectTest < BulkDataV101::BulkDataExportNoAuthRejectTest
      id :bulk_data_group_no_auth_reject
      input :group_id

      config(
        options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
      )
    end
  end
end

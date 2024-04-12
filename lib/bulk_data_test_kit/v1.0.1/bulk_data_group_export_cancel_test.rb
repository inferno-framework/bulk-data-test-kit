# frozen_string_literal: true

require_relative 'bulk_data_export_cancel_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupExportCancelTest < BulkDataV101::BulkDataExportCancelTest
      id :bulk_data_export_group_cancel
      input :group_id

      config(
        options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
      )
    end
  end
end

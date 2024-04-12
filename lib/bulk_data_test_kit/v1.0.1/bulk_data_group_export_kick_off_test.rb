# frozen_string_literal: true

require_relative 'bulk_data_export_kick_off_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupKickOffTest < BulkDataV101::BulkDataKickOffTest
      id :bulk_data_group_kick_off
      input :group_id

      config(
        options: { resource_type: 'Group', bulk_export_url: 'Group/[group_id]/$export' }
      )
    end
  end
end

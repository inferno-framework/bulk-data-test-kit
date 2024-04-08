# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_export_cancel_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSystemExportCancelGroup < Inferno::TestGroup
      id :bulk_data_system_export_cancel_group
      title 'System Level Export Cancel Tests'
      description %(
        Verify that the Bulk Data server supports cancelling requested system level exports.
        This group initiates a new export and immediately cancels it to verify
        correct behavior.
      )

      input :bearer_token, 
            optional: true

      output :system_cancelled_polling_url

      test from: :bulk_data_export_cancel,
           id: :bulk_data_system_export_cancel,
           config: {
             outputs: { cancelled_polling_url: { name: :system_cancelled_polling_url } },
             options: { resource_type: 'system', bulk_export_url: '$export' }
           }
    end
  end
end

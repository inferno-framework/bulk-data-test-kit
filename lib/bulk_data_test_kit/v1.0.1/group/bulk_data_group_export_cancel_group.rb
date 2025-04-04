# frozen_string_literal: true

require_relative '../../export_kick_off_performer'
require_relative '../bulk_data_group_export_cancel_test'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataGroupExportCancelGroup < Inferno::TestGroup
      id :bulk_data_group_export_cancel_group
      title 'Group Compartment Export Cancel Tests'
      description %(
        Verify that the Bulk Data server supports cancelling requested group exports.
        This group initiates a new export and immediately cancels it to verify
        correct behavior.
      )

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true
      input :group_id,
            title: 'Group ID',
            description: 'The Group ID associated with the group of patients to be exported.'

      test from: :bulk_data_export_group_cancel
    end
  end
end

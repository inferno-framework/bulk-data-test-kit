# frozen_string_literal: true

require_relative '../../v1.0.1/system_export/bulk_data_system_export_cancel_group'
require_relative '../bulk_data_export_cancel_test'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSystemExportCancelGroup < BulkDataV101::BulkDataSystemExportCancelGroup
      id :bulk_data_system_export_cancel_group_stu2

      test from: :bulk_data_export_cancel_stu2,
           id: :bulk_data_system_export_cancel_stu2,
           config: {
             inputs: { cancelled_polling_url: { name: :system_cancelled_polling_url } }
           }
    end
  end
end

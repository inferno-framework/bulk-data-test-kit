# frozen_string_literal: true

require_relative 'bulk_data_client_wait_test'
require_relative 'bulk_data_client_kick_off_test'
require_relative 'bulk_data_client_status_test'
require_relative 'bulk_data_client_output_test'
require_relative 'bulk_data_client_delete_test'

module BulkDataTestKit
  module BulkDataV200Client
    class ExportGroup < Inferno::TestGroup
      title 'Bulk Data Client Export Tests'

      description %(
        The Bulk Data Client Export tests verify the ability of a client to:
          - Kick-off a new bulk data export request
          - Poll the in-progress request for status updates
          - Download a completed bulk data export file
          - Delete the export
      )

      id :bulk_data_client_export_group

      run_as_group

      test from: :bulk_data_client_wait
      test from: :bulk_data_client_kick_off
      test from: :bulk_data_client_status
      test from: :bulk_data_client_output
      test from: :bulk_data_client_delete
    end
  end
end

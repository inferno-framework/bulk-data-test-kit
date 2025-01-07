# frozen_string_literal: true

require_relative '../tests/export_wait'
require_relative '../tests/kick_off'
require_relative '../tests/status'
require_relative '../tests/output'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Groups
        # Bulk Data Client Export Tests
        class Export < Inferno::TestGroup
          title 'Bulk Data Client Export Tests'

          description %(
            The Bulk Data Client Export tests verify the ability of a client to:
              - Kick-off a new bulk data export request
              - Poll the in-progress request for status updates
              - Download a completed bulk data export file
          )

          id :bulk_data_client_export_group

          run_as_group

          test from: :bulk_data_client_export_wait
          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_status
          test from: :bulk_data_client_output
        end
      end
    end
  end
end

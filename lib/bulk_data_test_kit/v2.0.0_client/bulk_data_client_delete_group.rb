# frozen_string_literal: true

require_relative 'bulk_data_client_delete_wait_test'
require_relative 'bulk_data_client_kick_off_test'
require_relative 'bulk_data_client_delete_test'

module BulkDataTestKit
  module BulkDataV200Client
    # Bulk Data Client Delete Tests
    class DeleteGroup < Inferno::TestGroup
      title 'Bulk Data Client Delete Tests'

      description %(
        The Bulk Data Client Delete tests verify the ability of a client to delete
        a kicked-off bulk data export request.
      )

      id :bulk_data_client_delete_group

      run_as_group

      test from: :bulk_data_client_delete_wait
      test from: :bulk_data_client_kick_off
      test from: :bulk_data_client_delete
    end
  end
end

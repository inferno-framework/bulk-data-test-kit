# frozen_string_literal: true

require_relative '../tests/delete_wait'
require_relative '../tests/kick_off'
require_relative '../tests/delete'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Groups
        # Bulk Data Client Delete Tests
        class Delete < Inferno::TestGroup
          title 'Bulk Data Client Delete Tests'

          description %(
            The Bulk Data Client Delete tests verify the ability of a client to delete
            a kicked-off bulk data export request.
          )

          id :bulk_data_client_delete_group

          run_as_group

          test from: :bulk_data_client_delete_wait
          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_kick_off
          test from: :bulk_data_client_delete
        end
      end
    end
  end
end

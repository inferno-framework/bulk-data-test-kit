# frozen_string_literal: true

require_relative '../tags'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Endpoints
        # Delete Endpoint
        class Delete < Inferno::DSL::SuiteEndpoint
          include Tags

          def test_run_identifier
            export_id
          end

          def make_response
            response.status = 202
          end

          def tags
            [DELETE_TAG]
          end

          def export_id
            request.params[:export_id]
          end
        end
      end
    end
  end
end

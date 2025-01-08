# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      # Delete Endpoint
      class Delete < Inferno::DSL::SuiteEndpoint
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

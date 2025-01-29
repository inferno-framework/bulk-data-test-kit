# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      # Delete Endpoint
      class Delete < Inferno::DSL::SuiteEndpoint
        def test_run_identifier
          request.get_header('HTTP_AUTHORIZATION')&.split&.last
        end

        def make_response
          response.status = 202
        end

        def tags
          [DELETE_TAG]
        end
      end
    end
  end
end

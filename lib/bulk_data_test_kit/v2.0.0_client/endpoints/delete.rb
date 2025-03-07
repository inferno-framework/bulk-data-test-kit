# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class Delete < Inferno::DSL::SuiteEndpoint
        include ServerProxy

        def test_run_identifier
          request.get_header('HTTP_AUTHORIZATION')&.split&.last
        end

        def make_response
          response.status = 202
        end

        def tags
          [DELETE_TAG]
        end

        def job_id
          request.params[:job_id]
        end
      end
    end
  end
end

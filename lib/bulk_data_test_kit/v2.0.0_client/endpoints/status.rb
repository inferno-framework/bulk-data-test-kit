# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      # Status Endpoint
      class Status < Inferno::DSL::SuiteEndpoint
        include URLs

        def test_run_identifier
          request.get_header('HTTP_AUTHORIZATION')&.split&.last
        end

        def make_response
          response.status = 200
          response.body = response_body.to_json
          response.format = :json
        end

        def tags
          [STATUS_TAG]
        end

        def response_body
          {
            transactionTime: DateTime.now.iso8601,
            request: kickoff_url,
            requiresAccessToken: true,
            output: [{
              type: 'Patient',
              url: output_url
            }],
            error: []
          }
        end
      end
    end
  end
end

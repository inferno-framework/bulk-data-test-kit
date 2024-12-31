# frozen_string_literal: true

require_relative '../tags'
require_relative '../urls'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Endpoints
        # Status Endpoint
        class Status < Inferno::DSL::SuiteEndpoint
          include Tags
          include URLs

          def test_run_identifier
            export_id
          end

          def make_response
            response.status = 200
            response.body = response_body.to_json
            response.format = :json
          end

          def tags
            [STATUS_TAG]
          end

          def export_id
            request.params[:export_id]
          end

          def response_body
            {
              transactionTime: DateTime.now.iso8601,
              request: kickoff_url(export_id),
              requiresAccessToken: false,
              output: [{
                type: 'Patient',
                url: output_url(export_id)
              }],
              error: []
            }
          end
        end
      end
    end
  end
end

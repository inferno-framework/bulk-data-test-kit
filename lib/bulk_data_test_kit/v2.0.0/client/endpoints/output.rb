# frozen_string_literal: true

require_relative '../tags'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Endpoints
        # Output Endpoint
        class Output < Inferno::DSL::SuiteEndpoint
          include Tags

          def test_run_identifier
            export_id
          end

          def make_response
            response.status = 200
            response.headers['Content-Type'] = 'application/fhir+ndjson'
            response.body = "#{FHIR::Patient.new.to_json.squish}\n"
          end

          def tags
            [OUTPUT_TAG]
          end

          def export_id
            request.params[:export_id]
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class Output < Inferno::DSL::SuiteEndpoint
        include ServerProxy

        def test_run_identifier
          request.get_header('HTTP_AUTHORIZATION')&.split&.last
        end

        # Proxy the request to the reference server for a completed output file,
        # using the same id provided with the completed status request.
        def make_response
          server_response = proxy_client.get("Binary/#{binary_id}")

          case server_response.status
          when 200
            response.status = 200
            response.headers['Content-Type'] = 'application/fhir+ndjson'
          else
            response.status = server_response.status
          end
          response.body = server_response.body
        end

        def tags
          [OUTPUT_TAG]
        end

        def binary_id
          request.params[:binary_id]
        end
      end
    end
  end
end

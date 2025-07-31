# frozen_string_literal: true

require 'smart_app_launch_test_kit'

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class Status < Inferno::DSL::SuiteEndpoint
        include URLs
        include ServerProxy

        def test_run_identifier
          return request.params[:session_path] if request.params[:session_path].present?

          SMARTAppLaunch::MockSMARTServer.issued_token_to_client_id(
            request.headers['authorization']&.delete_prefix('Bearer ')
          )
        end

        # Proxy the request to the reference server using the same `_jobId`` we received
        # on kickoff, and respond with the current status. If the status is complete,
        # return the output adjusted to point at Inferno.
        def make_response
          server_response = proxy_client.get("$export-poll-status?_jobId=#{job_id}")

          case server_response.status
          when 202
            # In-Progress Status
            response.status = 202
            response.headers['retry-after'] = 120
          when 200
            # Complete Status
            body = JSON.parse(server_response.body)
            response.status = 200
            response.body = response_body(body).to_json
            response.format = :json
          else
            response.status = server_response.status
            response.body = server_response.body
          end
        end

        def tags
          [STATUS_TAG]
        end

        def response_body(body)
          output = body['output']&.map do |binary|
            binary['url'] = rewrite_url_base(binary['url'])
            binary
          end

          {
            transactionTime: DateTime.now.iso8601,
            request: rewrite_url_base(body['request']),
            requiresAccessToken: true,
            output: output || [],
            error: []
          }
        end

        def job_id
          request.params[:job_id]
        end
      end
    end
  end
end

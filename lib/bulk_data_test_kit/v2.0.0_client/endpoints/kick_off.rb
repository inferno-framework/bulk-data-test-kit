# frozen_string_literal: true
require 'smart_app_launch_test_kit'

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class KickOff < Inferno::DSL::SuiteEndpoint
        include URLs
        include ServerProxy

        def test_run_identifier
          return request.params[:session_path] if request.params[:session_path].present?

          SMARTAppLaunch::MockSMARTServer.issued_token_to_client_id(
            request.headers['authorization']&.delete_prefix('Bearer ')
          )
        end

        # Proxy the request to the reference server, and re-use the returned '_jobId' as
        # the identifier we'll return to the user for our own `content-location` header.
        def make_response
          server_response = proxy_kickoff
          case server_response.status
          when 202
            server_status_url = server_response.headers['content-location']
            response.status = 202
            response.headers['content-location'] = status_url.gsub(':job_id', job_id(server_status_url))
          else
            response.status = server_response.status
            response.body = server_response.body
          end
        end

        def tags
          case request_type
          when PATIENT_EXPORT_TYPE
            [KICKOFF_TAG, PATIENT_KICKOFF_TAG]
          when GROUP_EXPORT_TYPE
            [KICKOFF_TAG, GROUP_KICKOFF_TAG]
          when SYSTEM_EXPORT_TYPE
            [KICKOFF_TAG, SYSTEM_KICKOFF_TAG]
          end
        end

        def proxy_kickoff
          case request_type
          when PATIENT_EXPORT_TYPE
            proxy_client.get('$export', request_params)
          when GROUP_EXPORT_TYPE
            proxy_client.get("#{request_type}/#{group_id}/$export", request_params)
          when SYSTEM_EXPORT_TYPE
            proxy_client.get('$export', request_params)
          end
        end

        # Collect request params to forward to the reference server
        def request_params
          request.params.to_h.stringify_keys
        end

        def request_type
          path_component_before_export = request.path_info.split['/'][-2].downcase
          if path_component_before_export == 'fhir'
            SYSTEM_EXPORT_TYPE
          elsif path_component_before_export == 'patient'
            PATIENT_EXPORT_TYPE
          else
            GROUP_EXPORT_TYPE
          end
        end

        def group_id
          request.params[:group_id]
        end

        def job_id(url)
          CGI.parse(URI.parse(url).query)['_jobId']&.first
        end
      end
    end
  end
end

# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class KickOff < Inferno::DSL::SuiteEndpoint
        include URLs
        include ServerProxy

        def test_run_identifier
          request.get_header('HTTP_AUTHORIZATION')&.split&.last
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
            [PATIENT_KICKOFF_TAG]
          when GROUP_EXPORT_TYPE
            [GROUP_KICKOFF_TAG]
          when SYSTEM_EXPORT_TYPE
            [SYSTEM_KICKOFF_TAG]
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
          (request.params[:type] || SYSTEM_EXPORT_TYPE).titleize
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

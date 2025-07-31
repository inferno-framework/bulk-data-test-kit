# frozen_string_literal: true

require 'smart_app_launch_test_kit'

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      class Delete < Inferno::DSL::SuiteEndpoint
        include ServerProxy

        def test_run_identifier
          return request.params[:session_path] if request.params[:session_path].present?

          SMARTAppLaunch::MockSMARTServer.issued_token_to_client_id(
            request.headers['authorization']&.delete_prefix('Bearer ')
          )
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

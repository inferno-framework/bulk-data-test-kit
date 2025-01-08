# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    module Endpoints
      # Kick Off Endpoint
      class KickOff < Inferno::DSL::SuiteEndpoint
        include URLs

        def test_run_identifier
          export_id
        end

        def make_response
          response.status = 202
          response.headers['Content-Location'] = status_url(export_id)
        end

        def tags
          case request_type.titleize
          when PATIENT_EXPORT_TYPE
            [PATIENT_KICKOFF_TAG]
          when GROUP_EXPORT_TYPE
            [GROUP_KICKOFF_TAG]
          when SYSTEM_EXPORT_TYPE
            [SYSTEM_KICKOFF_TAG]
          end
        end

        def export_id
          request.params[:export_id]
        end

        def request_type
          request.params[:type] || SYSTEM_EXPORT_TYPE
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative 'export_kick_off_performer'
require_relative 'bulk_data_test_kit_properties'

module BulkDataTestKit
  module BulkDataExportCancelTests
    extend Forwardable

    def_delegators 'self.class', :properties
    def_delegators 'properties',
                   :resource_type,
                   :bulk_export_url

    def perform_export_cancel_test
      use_token = !smart_auth_info.access_token.blank?
      url = bulk_export_url.dup
      if resource_type == 'Group'
        skip_if group_id.blank?, 'Group id is blank, skipping test.'
        url = bulk_export_url.gsub('[group_id]', group_id) if resource_type == 'Group'
      end

      perform_export_kick_off_request(use_token:, url:)
      assert_response_status(202)
      begin
        request.response_header('content-location')&.value
      ensure
        delete_export_kick_off_request
      end
    end

    def perform_cancelled_polling_test(bulk_cancelled_polling_url)
      skip 'No polling url available' unless bulk_cancelled_polling_url.present?

      get(bulk_cancelled_polling_url, headers: { authorization: "Bearer #{smart_auth_info.access_token}", accept: 'application/json' })

      assert_response_status(404)

      assert_valid_json(response[:body])
      response_body = JSON.parse(response[:body])

      assert response_body['resourceType'] == 'OperationOutcome', 'Server did not return an OperationOutcome'
      assert_valid_resource(resource: FHIR::OperationOutcome.new(response_body))
    end
  end
end

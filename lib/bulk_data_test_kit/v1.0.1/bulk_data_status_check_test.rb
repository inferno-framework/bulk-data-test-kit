# frozen_string_literal: true

require_relative '../export_operation_tests'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataStatusCheckTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests

      id :bulk_data_status_check

      title 'Bulk Data Server returns "202 Accepted" or "200 OK" for status check'
      description <<~DESCRIPTION
        Clients SHOULD follow an exponential backoff approach when polling for status. Servers SHOULD respond with

        * In-Progress Status: HTTP Status Code of 202 Accepted
        * Complete Status: HTTP status of 200 OK and Content-Type header of application/json

        The JSON object of Complete Status SHALL contain these required field:

        * transactionTime, request, requiresAccessToken, output, and error
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-status-request'

      verifies_requirements 'hl7.fhir.uv.bulkdata_1.0.0@132',
                            'hl7.fhir.uv.bulkdata_1.0.0@144',
                            'hl7.fhir.uv.bulkdata_1.0.0@145',
                            'hl7.fhir.uv.bulkdata_1.0.0@147',
                            'hl7.fhir.uv.bulkdata_1.0.0@150',
                            'hl7.fhir.uv.bulkdata_1.0.0@151',
                            'hl7.fhir.uv.bulkdata_1.0.0@152',
                            'hl7.fhir.uv.bulkdata_1.0.0@155',
                            'hl7.fhir.uv.bulkdata_1.0.0@156',
                            'hl7.fhir.uv.bulkdata_1.0.0@157',
                            'hl7.fhir.uv.bulkdata_1.0.0@159',
                            'hl7.fhir.uv.bulkdata_1.0.0@160',
                            'hl7.fhir.uv.bulkdata_1.0.0@161',
                            'hl7.fhir.uv.bulkdata_1.0.0@191',
                            'hl7.fhir.uv.bulkdata_1.0.0@192',
                            'hl7.fhir.uv.bulkdata_1.0.0@193'

      input :polling_url, :bulk_timeout
      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true

      output :status_response, :requires_access_token

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type]
        )
      end

      run do
        requires_access_token, status_response = export_status_check_success(polling_url)

        output(requires_access_token:)
        output status_response:
      end
    end
  end
end

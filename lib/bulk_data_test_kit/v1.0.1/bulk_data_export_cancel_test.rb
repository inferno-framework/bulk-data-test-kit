# frozen_string_literal: true

require_relative '../export_cancel_tests'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataExportCancelTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportCancelTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :bulk_data_export_cancel

      title 'Bulk Data Server returns "202 Accepted" for delete request'
      description <<~DESCRIPTION
        After a bulk data request has been started, a client MAY send a delete request to the URL provided in the Content-Location header to cancel the request.
        Bulk Data Server MUST support client's delete request and return HTTP Status Code of "202 Accepted"
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1/export/index.html#bulk-data-delete-request'

      verifies_requirements 'hl7.fhir.uv.bulkdata_1.0.0@305',
                            'hl7.fhir.uv.bulkdata_1.0.0@306'

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true
      output :cancelled_polling_url

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type],
          bulk_export_url: config.options[:bulk_export_url]
        )
      end

      run do
        cancelled_polling_url = perform_export_cancel_test
        output cancelled_polling_url:
      end
    end
  end
end

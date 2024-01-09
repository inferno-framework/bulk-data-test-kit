require_relative '../../export_cancel_tests.rb'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataSystemExportCancelTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportCancelTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :bulk_data_system_export_cancel

      title 'Bulk Data Server returns "202 Accepted" for delete request'
      description <<~DESCRIPTION
        After a bulk data request has been started, a client MAY send a delete request to the URL provided in the Content-Location header to cancel the request.
        Bulk Data Server MUST support client's delete request and return HTTP Status Code of "202 Accepted"
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-delete-request'

      output :system_export_cancelled_polling_url

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          bulk_export_url: "$export"
        )
      end

      run do
        cancelled_polling_url = perform_export_cancel_test
        output system_export_cancelled_polling_url: cancelled_polling_url
      end
    end
  end
end

    
# frozen_string_literal: true

require_relative '../export_operation_tests'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataKickOffTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :bulk_data_kick_off

      title 'Bulk Data Server returns "202 Accepted" and "Content-location" for bulk data $export operations'
      description <<~DESCRIPTION
        Response - Success

        * HTTP Status Code of 202 Accepted
        * Content-Location header with the absolute URL of an endpoint for subsequent status requests (polling location)
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#response---success'

      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true
      output :polling_url

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type],
          bulk_export_url: config.options[:bulk_export_url]
        )
      end

      run do
        polling_url = export_kick_off_success
        output polling_url:
      end
    end
  end
end

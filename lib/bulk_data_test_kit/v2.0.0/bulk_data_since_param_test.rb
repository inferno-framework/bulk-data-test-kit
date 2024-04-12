# frozen_string_literal: true

require_relative '../export_parameters_tests'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataSinceParamTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportParametersTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :since_in_export_response

      title 'Bulk Data Server supports "_since" query parameter for bulk data export'
      description <<~DESCRIPTION
        This test verifies that the server accepts an export request with the
        `[_since](http://hl7.org/fhir/uv/bulkdata/STU2/export.html#query-parameters)`
        query parameter.  It initiates a new export using a _since parameter of
        one week ago, and ensures that the export was initiated succesfully.

        The test does not attempt to verify that resources returned were
        modified after the _since date that was requested, because the Bulk Data
        specification provides latitude in determining exactly what data is
        returned by the server.  The purpose of this test is to ensure that
        export requests with this parameter are accepted and to highlight that
        support of this parameter is required.

        After the export was successfully initiated, it is then cancelled.
      DESCRIPTION

      input :bearer_token,
            optional: true
      input :since_timestamp,
            title: 'Timestamp for _since parameter',
            description: 'A timestamp formatted as a FHIR instant which will be used to test the ' \
                        "server's support for the `_since` query parameter",
            default: 1.week.ago.iso8601

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type],
          bulk_export_url: config.options[:bulk_export_url]
        )
      end

      run do
        perform_since_param_test(since_timestamp)
      end
    end
  end
end

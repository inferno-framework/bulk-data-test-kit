# frozen_string_literal: true

require_relative '../export_parameters_tests'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputFormatParamTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportParametersTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :output_format_in_export_response

      title 'Bulk Data Server supports "_outputFormat" query parameter for bulk data export'
      description <<~DESCRIPTION
        [_outputFormat](http://hl7.org/fhir/uv/bulkdata/STU2/export.html#query-parameters):
        The format for the requested Bulk Data files to be
        generated as per FHIR Asynchronous Request Pattern. Defaults to
        application/fhir+ndjson. The server SHALL support Newline Delimited
        JSON, but MAY choose to support additional output formats. The server
        SHALL accept the full content type of application/fhir+ndjson as well
        as the abbreviated representations application/ndjson and ndjson.
      DESCRIPTION

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type],
          bulk_export_url: config.options[:bulk_export_url]
        )
      end

      run do
        perform_outputFormat_param_test
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../export_operation_tests'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataOutputCheckTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests

      id :bulk_data_output_check

      title 'Bulk Data Server returns output with type and url for status complete'
      description <<~DESCRIPTION
        The value of output field is an array of file items with one entry for each generated file.
        If no resources are returned from the kick-off request, the server SHOULD return an empty array.

        Each file item SHALL contain the following fields:

        * type - the FHIR resource type that is contained in the file.

        Each file SHALL contain resources of only one type, but a server MAY create more than one file for each resource type returned.

        * url - the path to the file. The format of the file SHOULD reflect that requested in the _outputFormat parameter of the initial kick-off request.
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#response---complete-status'

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@164',
                            'hl7.fhir.uv.bulkdata_2.0.0@167',
                            'hl7.fhir.uv.bulkdata_2.0.0@168',
                            'hl7.fhir.uv.bulkdata_2.0.0@170',
                            'hl7.fhir.uv.bulkdata_2.0.0@171'

      input :status_response

      output :status_output, :bulk_download_url

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: config.options[:resource_type]
        )
      end

      run do
        status_output, bulk_download_url = check_bulk_data_output(status_response)

        output status_output:,
               bulk_download_url:
      end
    end
  end
end

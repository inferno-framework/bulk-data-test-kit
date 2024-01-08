require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientKickOffTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests
      include BulkDataTestKit::ExportKickOffPerformer

      id :bulk_data_patient_kick_off

      title 'Bulk Data Server returns "202 Accepted" and "Content-location" for $export operation'
      description <<~DESCRIPTION
          Response - Success

          * HTTP Status Code of 202 Accepted
          * Content-Location header with the absolute URL of an endpoint for subsequent status requests (polling location)
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#response---success'

      output :patient_polling_url

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: 'Patient',
          bulk_export_url: "Patient/$export"
        )
      end

      run do
        polling_url =  export_kick_off_success
        output patient_polling_url: polling_url
      end
    end
  end
end

    
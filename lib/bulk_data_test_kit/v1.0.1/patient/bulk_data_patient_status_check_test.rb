require_relative '../../export_operation_tests.rb'

module BulkDataTestKit
  module BulkDataV101
    class BulkDataPatientStatusCheckTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportOperationTests

      id :bulk_data_patient_status_check

      title 'Bulk Data Server returns "202 Accepted" or "200 OK" for status check'
      description <<~DESCRIPTION
        Clients SHOULD follow an exponential backoff approach when polling for status. Servers SHOULD respond with

        * In-Progress Status: HTTP Status Code of 202 Accepted
        * Complete Status: HTTP status of 200 OK and Content-Type header of application/json

        The JSON object of Complete Status SHALL contain these required field:

        * transactionTime, request, requiresAccessToken, output, and error
      DESCRIPTION
      # link 'http://hl7.org/fhir/uv/bulkdata/STU1.0.1/export/index.html#bulk-data-status-request'


      input :patient_polling_url

      output :patient_status_response, :patient_requires_access_token

      def self.properties
        @properties ||= BulkDataTestKitProperties.new(
          resource_type: 'Patient'
        )
      end

      run do
        requires_access_token, status_response = export_status_check_success(patient_polling_url)

        output patient_requires_access_token: requires_access_token
        output patient_status_response: status_response
      end
    end
  end
end

    
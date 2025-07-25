# frozen_string_literal: true

require_relative '../export_cancel_tests'

module BulkDataTestKit
  module BulkDataV200
    class BulkDataExportCancelTest < Inferno::Test
      include BulkDataTestKit::BulkDataExportCancelTests

      title 'Bulk Data Server returns a 404 and OperationOutcome for polling requests to cancelled exports'
      description <<~DESCRIPTION
        > Following the delete request, when subsequent requests are made to the
          polling location, the server SHALL return a 404 Not Found error and an
          associated FHIR OperationOutcome in JSON format.

        http://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-delete-request
      DESCRIPTION

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@122',
                            'hl7.fhir.uv.bulkdata_2.0.0@308',
                            'hl7.fhir.uv.bulkdata_2.0.0@309'

      id :bulk_data_export_cancel_stu2

      input :cancelled_polling_url
      input :smart_auth_info,
            type: :auth_info,
            options: { mode: 'access' },
            optional: true

      run do
        perform_cancelled_polling_test(cancelled_polling_url)
      end
    end
  end
end

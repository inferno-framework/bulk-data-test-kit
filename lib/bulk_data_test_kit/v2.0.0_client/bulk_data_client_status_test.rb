# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class StatusTest < Inferno::Test
      title 'Bulk Data Status Request'

      description %(
        This test verifies that after a Bulk Data request has been started, the client can
        [poll the status URL](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-status-request)
        provided in the Content-Location header, as as described in the
        [FHIR Asynchronous Request Pattern](https://www.hl7.org/fhir/R4/async.html).
      )

      id :bulk_data_client_status

      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@123'

      run do
        assert load_tagged_requests(STATUS_TAG).any?, fail_message
      end

      def fail_message
        'Did not receive a status request.'
      end
    end
  end
end

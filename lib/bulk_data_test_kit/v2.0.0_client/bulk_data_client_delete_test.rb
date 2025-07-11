# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class DeleteTest < Inferno::Test
      title 'Bulk Data Delete Request'

      description %(
        This test verifies that after a Bulk Data request has been started, the client can send a
        DELETE request to the URL provided in the Content-Location header to
        [delete the request](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-delete-request),
        as described in the [FHIR Asynchronous Request Pattern](https://www.hl7.org/fhir/R4/async.html).
      )

      id :bulk_data_client_delete

      run do
        assert load_tagged_requests(DELETE_TAG).any?, fail_message
      end

      def fail_message
        'Did not receive a delete request.'
      end
    end
  end
end

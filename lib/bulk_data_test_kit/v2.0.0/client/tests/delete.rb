# frozen_string_literal: true

require_relative '../tags'
require_relative '../urls'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Tests
        # Bulk Data Client - Delete
        class Delete < Inferno::Test
          include Tags
          include URLs

          FAIL = 'Did not receive a delete request.'

          title 'Bulk Data Delete Request'

          description %(
            This test verifies that after a Bulk Data request has been started, the client can send a
            DELETE request to the URL provided in the Content-Location header to
            [delete the request](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-delete-request),
            as described in the [FHIR Asynchronous Request Pattern](https://www.hl7.org/fhir/R4/async.html).
          )

          id :bulk_data_client_delete

          verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@119'

          run do
            assert load_tagged_requests(DELETE_TAG).any?, FAIL
          end
        end
      end
    end
  end
end

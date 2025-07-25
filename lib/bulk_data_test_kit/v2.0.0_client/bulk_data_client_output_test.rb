# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class OutputTest < Inferno::Test
      title 'Bulk Data Output File Request'

      description %(
        This test verifies that the client, using the URL supplied in the Complete Status response body,
        can [download](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-output-file-request)
        the generated Bulk Data file.
      )

      id :bulk_data_client_output

      run do
        assert load_tagged_requests(OUTPUT_TAG).any?, fail_message
      end

      def fail_message
        'Did not receive a download request.'
      end
    end
  end
end

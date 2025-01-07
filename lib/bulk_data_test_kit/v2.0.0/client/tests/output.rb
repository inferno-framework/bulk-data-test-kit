# frozen_string_literal: true

require_relative '../tags'

module BulkDataTestKit
  module BulkDataV200
    module Client
      module Tests
        # Bulk Data Client Output
        class Output < Inferno::Test
          include Tags

          title 'Bulk Data Output File Request'

          description %(
            This test verifies that the client, using the URL supplied in the Complete Status response body,
            can [download](https://hl7.org/fhir/uv/bulkdata/STU2/export.html#bulk-data-output-file-request)
            the generated Bulk Data file.
          )

          id :bulk_data_client_output

          verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@200'

          run do
            assert load_tagged_requests(OUTPUT_TAG).any?, fail_message
          end

          def fail_message
            'Did not receive a download request.'
          end
        end
      end
    end
  end
end

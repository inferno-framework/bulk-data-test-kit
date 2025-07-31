# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputFileErrorAttestationTest < Inferno::Test
      title 'Responds to errored Output File Requests with HTTP 4XX or 5XX'
      id :bulkdata_output_file_error
      description %(
        The Bulk Data server responds to an errored Bulk Data Output File Request with HTTP Status Code of `4XX` or
        `5XX`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@210'

      input :output_file_error_correct,
            title: 'Bulk Data Export Response Handling: Responds to errored Output File Requests with HTTP 4XX or 5XX',
            description: %(
              I attest that the Bulk Data server responds to an errored Bulk Data Output File Request with HTTP Status
              Code of `4XX` or `5XX`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_error_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_error_correct == 'true',
               'Bulk Data server does not respond to errored Output File Requests with HTTP 4XX or 5XX.'
        pass output_file_error_note if output_file_error_note.present?
      end
    end
  end
end

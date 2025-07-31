# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputFileSuccessAttestationTest < Inferno::Test
      title 'Responds to successful Output File Requests with HTTP 200 OK'
      id :bulkdata_output_file_success
      description %(
        The Bulk Data server responds to a successful Output File Request with HTTP status of `200 OK`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@206'

      input :output_file_success_correct,
            title: 'Bulk Data Export Response Handling: Responds to successful Output File Requests with HTTP 200 OK',
            description: %(
              I attest that the Bulk Data server responds to a successful Output File Request with HTTP status of
              `200 OK`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_success_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_success_correct == 'true',
               'Bulk Data server does not respond to successful Output File Requests with HTTP 200 OK.'
        pass output_file_success_note if output_file_success_note.present?
      end
    end
  end
end

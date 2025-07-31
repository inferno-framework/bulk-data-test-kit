# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataKickoffErrorResponseAttestationTest < Inferno::Test
      title 'Responds to errored Kick-off Requests with appropriate HTTP status and OperationOutcome'
      id :bulkdata_kickoff_error_response
      description %(
        The Bulk Data server responds to errored Kick-off Requests with an HTTP 4XX or 5XX status code and a response
        body containing a FHIR OperationOutcome resource in JSON format.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@303',
                            'hl7.fhir.uv.bulkdata_2.0.0@304'

      input :kickoff_error_response_correct,
            title: %(
              Bulk Data Export Response Handling: Responds to errored Kick-off Requests with appropriate HTTP
              status and OperationOutcome
            ),
            description: %(
              I attest that the Bulk Data server responds to errored Kick-off Requests with an HTTP 4XX or 5XX
              status code and a response body containing a FHIR OperationOutcome resource in JSON format.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :kickoff_error_response_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert kickoff_error_response_correct == 'true',
               'Bulk Data server does not respond to errored Kick-off Requests with appropriate HTTP status
                and OperationOutcome.'
        pass kickoff_error_response_note if kickoff_error_response_note.present?
      end
    end
  end
end

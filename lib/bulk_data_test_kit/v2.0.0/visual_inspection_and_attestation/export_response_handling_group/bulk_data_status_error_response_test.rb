# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataStatusErrorResponseAttestationTest < Inferno::Test
      title 'Responds to errored Status Requests with appropriate HTTP status and OperationOutcome'
      id :bulkdata_status_error_response
      description %(
        The Bulk Data server responds to errored Status Requests with an HTTP 4XX or 5XX status code and, when a body
        is present, uses the `application/fhir+json` Content-Type with a FHIR OperationOutcome resource.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@136',
                            'hl7.fhir.uv.bulkdata_2.0.0@137'

      input :status_error_response_correct,
            title: %(
             Bulk Data Export Response Handling: Responds to errored Status Requests with appropriate HTTP
             status and OperationOutcome
            ),
            description: %(
              I attest that the Bulk Data server responds to errored Status Requests with an HTTP 4XX or 5XX
              status code and, when a body is present, uses the `application/fhir+json` Content-Type with a
              FHIR OperationOutcome resource.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :status_error_response_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert status_error_response_correct == 'true',
               'Bulk Data server does not respond to errored Status Requests with appropriate HTTP status and
                OperationOutcome.'
        pass status_error_response_note if status_error_response_note.present?
      end
    end
  end
end

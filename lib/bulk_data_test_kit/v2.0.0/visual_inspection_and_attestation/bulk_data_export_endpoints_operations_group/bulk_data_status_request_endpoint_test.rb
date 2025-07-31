# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataStatusRequestEndpointAttestationTest < Inferno::Test
      title 'Supports Status Requests at polling content location'
      id :bulkdata_status_request_endpoint
      description %(
        The server supports Status Requests at the endpoint `GET [polling content location]`.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@310'

      input :status_request_endpoint_correct,
            title: 'Bulk Data Export Endpoints and Operations: Supports Status Requests at polling content location',
            description: %(
              I attest that the server supports Status Requests at the endpoint `GET [polling content location]`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :status_request_endpoint_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert status_request_endpoint_correct == 'true',
               'Bulk Data server does not support Status Requests at polling content location.'
        pass status_request_endpoint_note if status_request_endpoint_note.present?
      end
    end
  end
end

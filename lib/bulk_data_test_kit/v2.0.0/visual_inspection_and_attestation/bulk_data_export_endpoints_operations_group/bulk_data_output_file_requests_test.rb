# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataOutputFileRequestsAttestationTest < Inferno::Test
      title 'Supports Output File Requests at the endpoint'
      id :bulkdata_output_file_requests
      description %(
        The Bulk Data server supports Output File Requests at the endpoint returned in the status request's output
        field, using GET [url from status request output field].
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@204'

      input :output_file_requests_supported,
            title: 'Bulk Data Export Endpoints and Operations: Supports Output File Requests at the endpoint',
            description: %(
              I attest that the Bulk Data server supports Output File Requests at the endpoint returned in the status
              request's output field, using GET [url from status request output field],
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :output_file_requests_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert output_file_requests_supported == 'true',
               'Bulk Data server does not support Output File Requests at the endpoint as required.'
        pass output_file_requests_note if output_file_requests_note.present?
      end
    end
  end
end

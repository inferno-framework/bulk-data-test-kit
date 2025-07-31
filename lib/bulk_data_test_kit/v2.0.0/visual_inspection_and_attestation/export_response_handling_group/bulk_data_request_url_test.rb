# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataRequestUrlAttestationTest < Inferno::Test
      title 'Omits parameters from request URL for POST in Bulk Data response'
      id :bulkdata_request_url
      description %(
        In the case of a POST request, the request URL in the Bulk Data response does not include the request
        parameters.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@158'

      input :request_url_correct,
            title: %(
              Bulk Data Export Response Handling: Omits parameters from request URL for POST in Bulk Data response
            ),
            description: %(
              I attest that in the case of a POST request, the request URL in the Bulk Data response does not include
              the request parameters.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :request_url_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert request_url_correct == 'true',
               'Bulk Data response does not omit parameters from request URL for POST.'
        pass request_url_note if request_url_note.present?
      end
    end
  end
end

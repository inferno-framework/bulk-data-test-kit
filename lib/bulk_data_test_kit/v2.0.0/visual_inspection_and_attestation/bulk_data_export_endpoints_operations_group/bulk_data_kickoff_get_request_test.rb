# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class BulkDataKickoffGetRequestAttestationTest < Inferno::Test
      title 'Supports GET requests for kick-off'
      id :bulkdata_kickoff_get_request
      description %(
        The server supports GET requests for Bulk Data kick-off.
      )
      verifies_requirements 'hl7.fhir.uv.bulkdata_2.0.0@29'

      input :kickoff_get_request_correct,
            title: 'Bulk Data Export Endpoints and Operations: Supports GET requests for kick-off',
            description: %(
              I attest that the server supports GET requests for Bulk Data kick-off.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :kickoff_get_request_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert kickoff_get_request_correct == 'true',
               'Bulk Data server does not support GET requests for kick-off.'
        pass kickoff_get_request_note if kickoff_get_request_note.present?
      end
    end
  end
end

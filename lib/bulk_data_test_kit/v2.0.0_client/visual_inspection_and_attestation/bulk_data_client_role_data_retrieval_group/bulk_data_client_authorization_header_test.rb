# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class BulkDataClientAuthorizationHeaderAttestationTest < Inferno::Test
      title 'Includes Authorization header with Bearer token'
      id :bulkdata_client_authorization_header
      description %(
        The Bulk Data Client issues requests for FHIR data that include an Authorization header presenting the
        access_token as a Bearer token: `Authorization: Bearer {{access_token}}`.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@264'

      input :client_authorization_header_correct,
            title: %(
              Bulk Data Client Role and Data Retrieval: Includes Authorization header with Bearer token
            ),
            description: %(
              I attest that the Bulk Data Client issues requests for FHIR data that include an Authorization header
              presenting the access_token as a Bearer token: `Authorization: Bearer {{access_token}}`.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_authorization_header_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_authorization_header_correct == 'true',
               'Bulk Data Client does not include Authorization header with Bearer token as required.'
        pass client_authorization_header_note if client_authorization_header_note.present?
      end
    end
  end
end

# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200
    class PreAuthorizedClientAttestationTest < Inferno::Test
      title 'Pre-authorizes client'
      id :smart_pre_authorized_client
      description %(
        The client is pre-authorized by the server, and the server has already associated the client with the authority
        to access certain data before the client initiates an access token request.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@240'

      input :pre_authorized_client_correct,
            title: 'Scopes and Access: Pre-authorizes client',
            description: %(
              I attest that the client is pre-authorized by the server, and the server has already associated the
              client with the authority to access certain data before the client initiates an access token request.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :pre_authorized_client_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert pre_authorized_client_correct == 'true',
               'The client is not pre-authorized by the server as required.'
        pass pre_authorized_client_note if pre_authorized_client_note.present?
      end
    end
  end
end

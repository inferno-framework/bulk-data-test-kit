# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientSupportsEs384AttestationTest < Inferno::Test
      title 'Supports ES384 for the JWA header parameter'
      id :client_supports_es384
      description %(
        The client supports ES384 for the JSON Web Algorithm (JWA) header parameter as defined in RFC7518.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@309'

      input :client_supports_es384_correct,
            title: 'Client Key Management & JWK Registration: Client supports ES384 for the JWA header parameter',
            description: %(
              I attest that the client supports ES384 for the JSON Web Algorithm (JWA) header parameter as defined in
              RFC7518.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_supports_es384_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_supports_es384_correct == 'true',
               'Client does not support ES384 for the JWA header parameter as required.'
        pass client_supports_es384_note if client_supports_es384_note.present?
      end
    end
  end
end

# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientChoosesJwkCommunicationMethodAttestationTest < Inferno::Test
      title 'Chooses a server-supported method for communicating JWKs at registration'
      id :client_chooses_jwk_communication_method
      description %(
        The Client chooses a server-supported method for communicating JWKs at registration time.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@298'

      input :client_chooses_jwk_communication_method_correct,
            title: %(
              Client Key Management & JWK Registration: Chooses a server-supported method for communicating JWKs at
              registration
            ),
            description: %(
              I attest that the client chooses a server-supported method for communicating JWKs at registration time.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_chooses_jwk_communication_method_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_chooses_jwk_communication_method_correct == 'true',
               'Client does not choose a server-supported method for communicating JWKs at registration.'
        pass client_chooses_jwk_communication_method_note if client_chooses_jwk_communication_method_note.present?
      end
    end
  end
end

# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientProtectsPrivateKeyAttestationTest < Inferno::Test
      title 'Protects the associated private key from unauthorized disclosure and corruption'
      id :client_protects_private_key
      description %(
        The client protects the associated private key for the client-confidential-asymmetric capability from
        unauthorized disclosure and corruption.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@295'

      input :client_protects_private_key_correct,
            title: %(
              Client Key Management & JWK Registration: Protects the associated private key from unauthorized
              disclosure and corruption
            ),
            description: %(
              I attest that the client protects the associated private key for the client-confidential-asymmetric
              capability from unauthorized disclosure and corruption.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_protects_private_key_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_protects_private_key_correct == 'true',
               'Client does not protect the associated private key as required.'
        pass client_protects_private_key_note if client_protects_private_key_note.present?
      end
    end
  end
end

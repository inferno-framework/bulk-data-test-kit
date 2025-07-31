# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientRegistersPublicKeySetAttestationTest < Inferno::Test
      title 'Registers its public key set with the FHIR authorization server'
      id :client_registers_public_key_set
      description %(
        The client, before running against a FHIR server, registers its public key set with that FHIR server’s
        authorization service.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@291'

      input :client_registers_public_key_set_correct,
            title: %(
             Client Key Management & JWK Registration: Registers its public key set with the FHIR authorization server
            ),
            description: %(
              I attest that the client, before running against a FHIR server, registers its public key set with the
              FHIR authorization server.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_registers_public_key_set_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_registers_public_key_set_correct == 'true',
               'Client does not register its public key set with the FHIR authorization server as required.'
        pass client_registers_public_key_set_note if client_registers_public_key_set_note.present?
      end
    end
  end
end

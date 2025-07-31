# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwkPropertiesAttestationTest < Inferno::Test
      title 'Represents an asymmetric key with required properties'
      id :client_jwk_properties
      description %(
        Each JWK represents an asymmetric key by including kty and kid properties, with content conveyed using
        “bare key” properties  (i.e., direct base64 encoding of key material as integer values).
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@313'

      input :client_jwk_properties_correct,
            title: %(
             Client Key Management & JWK Registration: Each JWK represents an asymmetric key with required properties
            ),
            description: %(
              I attest that each JWK represents an asymmetric key by including kty and kid properties, with content
              conveyed using “bare key” properties  (i.e., direct base64 encoding of key material as integer values).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwk_properties_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwk_properties_correct == 'true',
               'Each JWK does not represent an asymmetric key with required properties.'
        pass client_jwk_properties_note if client_jwk_properties_note.present?
      end
    end
  end
end

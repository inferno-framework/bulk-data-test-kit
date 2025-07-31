# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwkRsaPropertiesAttestationTest < Inferno::Test
      title 'Includes n and e values in RSA public keys in JWK'
      id :client_jwk_rsa_properties
      description %(
        For RSA public keys, each JWK SHALL include n and e values (modulus and exponent).
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@314'

      input :client_jwk_rsa_properties_correct,
            title: 'Client Key Management & JWK Registration: Includes n and e values in RSA public keys in JWK',
            description: %(
              I attest that for RSA public keys, each JWK includes n and e values (modulus and exponent).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwk_rsa_properties_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwk_rsa_properties_correct == 'true',
               'RSA public keys in JWK do not include n and e values as required.'
        pass client_jwk_rsa_properties_note if client_jwk_rsa_properties_note.present?
      end
    end
  end
end

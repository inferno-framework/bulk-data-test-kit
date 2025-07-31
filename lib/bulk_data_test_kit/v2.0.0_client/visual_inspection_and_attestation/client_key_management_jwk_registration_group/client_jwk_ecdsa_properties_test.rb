# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwkEcdsaPropertiesAttestationTest < Inferno::Test
      title 'Includes crv, x, and y values in ECDSA public keys in JWK'
      id :client_jwk_ecdsa_properties
      description %(
        For ECDSA public keys, each JWK SHALL include crv, x, and y values (curve, x-coordinate, and y-coordinate,
        for EC keys).
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@315'

      input :client_jwk_ecdsa_properties_correct,
            title: %(
              Client Key Management & JWK Registration: Includes crv, x, and y values in ECDSA public keys in JWK
            ),
            description: %(
              I attest that for ECDSA public keys, each JWK includes crv, x, and y values (curve, x-coordinate, and
              y-coordinate, for EC keys).
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwk_ecdsa_properties_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwk_ecdsa_properties_correct == 'true',
               'ECDSA public keys in JWK do not include crv, x, and y values as required.'
        pass client_jwk_ecdsa_properties_note if client_jwk_ecdsa_properties_note.present?
      end
    end
  end
end

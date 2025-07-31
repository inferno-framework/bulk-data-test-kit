# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwtConstructionAttestationTest < Inferno::Test
      title 'Constructs authentication JWT with required headers and claims'
      id :client_jwt_construction
      description %(
        When generating a one-time-use authentication JWT, the client:
        - Signs the JWT with its private key (should be RS384 or ES384).
        - Sets the JWT header `alg` to the JWA algorithm used for signing.
        - Sets the JWT header `kid` to the identifier of the key-pair used to sign the JWT, unique within the
          client's JWK Set.
        - Sets the JWT header `typ` to "JWT".
        - If present, sets the JWT header `jku` to match the JWKS URL supplied at registration.
        - Sets the JWT claim `iss` to the client's client_id.
        - Sets the JWT claim `sub` to the client's client_id.
        - Sets the JWT claim `aud` to the FHIR authorization server's token URL.
        - Sets the JWT claim `exp` to the expiration time (no more than five minutes in the future).
        - Sets the JWT claim `jti` to a nonce string uniquely identifying the JWT.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@320',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@321',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@322',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@323',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@325',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@327',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@328',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@329',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@330',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@331',
                            'hl7.fhir.uv.smart-app-launch_2.2.0@332'

      input :client_jwt_construction_correct,
            title: %(
              Client Authentication & Token Request: Constructs authentication JWT with required headers and claims
            ),
            description: %(
              I attest that When generating a one-time-use authentication JWT, the client:
              - Signs the JWT with its private key (should be RS384 or ES384).
              - Sets the JWT header `alg` to the JWA algorithm used for signing.
              - Sets the JWT header `kid` to the identifier of the key-pair used to sign the JWT, unique within the
                client's JWK Set.
              - Sets the JWT header `typ` to "JWT".
              - If present, sets the JWT header `jku` to match the JWKS URL supplied at registration.
              - Sets the JWT claim `iss` to the client's client_id.
              - Sets the JWT claim `sub` to the client's client_id.
              - Sets the JWT claim `aud` to the FHIR authorization server's token URL.
              - Sets the JWT claim `exp` to the expiration time (no more than five minutes in the future).
              - Sets the JWT claim `jti` to a nonce string uniquely identifying the JWT.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwt_construction_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwt_construction_correct == 'true',
               'Client does not construct authentication JWT with all required headers and claims.'
        pass client_jwt_construction_note if client_jwt_construction_note.present?
      end
    end
  end
end

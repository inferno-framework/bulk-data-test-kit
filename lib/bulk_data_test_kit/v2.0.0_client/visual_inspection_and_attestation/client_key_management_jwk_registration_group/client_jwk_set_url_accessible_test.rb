# frozen_string_literal: true

module BulkDataTestKit
  module BulkDataV200Client
    class ClientJwkSetUrlAccessibleAttestationTest < Inferno::Test
      title 'Allows for Client JWK Set URL to be accessible via TLS without client authentication or authorization'
      id :client_jwk_set_url_accessible
      description %(
        For the URL to JWK Set method to register a JWK for use in the client-confidential-asymmetric capability,
        the value is accessible via TLS without client authentication or authorization.
      )
      verifies_requirements 'hl7.fhir.uv.smart-app-launch_2.2.0@302'

      input :client_jwk_set_url_accessible_correct,
            title: %(
              Client Key Management & JWK Registration: Allows for Client JWK Set URL to be accessible via TLS without
              client authentication or authorization',
            ),
            description: %(
              I attest that for the URL to JWK Set method to register a JWK for use in the
              client-confidential-asymmetric capability, the value is accessible via TLS without client authentication
              or authorization.
            ),
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                { label: 'Yes', value: 'true' },
                { label: 'No', value: 'false' }
              ]
            }
      input :client_jwk_set_url_accessible_note,
            title: 'Notes, if applicable:',
            type: 'textarea',
            optional: true

      run do
        assert client_jwk_set_url_accessible_correct == 'true',
               'Client JWK Set URL is not accessible via TLS without client authentication or authorization as
                required.'
        pass client_jwk_set_url_accessible_note if client_jwk_set_url_accessible_note.present?
      end
    end
  end
end
